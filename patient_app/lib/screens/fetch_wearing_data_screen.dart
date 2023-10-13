import 'dart:math';

import 'package:common_lib/models/patient_data_list.dart';
import 'package:common_lib/models/wearing_time.dart';
import 'package:common_lib/models/locale_text.dart';
import 'package:common_lib/models/wearing_time_list.dart';
import 'package:flutter/material.dart';

import '/data_collection_devices/data_collection_devices.dart';
import '/data_collection_devices/devices/available_devices.dart';

class FetchWearingDataScreen extends StatefulWidget {
  // FetchWearingDataScreen is a StatefulWidget that represents the screen. It takes two required parameters:
  const FetchWearingDataScreen({
    super.key,
    required this.device, // device: An enum value representing the type of device from which data will be fetched.
    required this.nextRoute, // nextRoute: A string representing the name of the next route to navigate to after data processing is complete.
  });

  static const String routeName = '/fetch-data-screen';
  final AvailableDevices device;
  final String nextRoute;

  @override
  State<FetchWearingDataScreen> createState() => _FetchWearingDataScreenState();
}

class _FetchWearingDataScreenState extends State<FetchWearingDataScreen> {
  late final DataCollectionDevice _dataCollectionDevice;
  late Future<bool> _hasFetchedData;
  late String _statusMessage;
  bool _isSending = false;

  // _FetchWearingDataScreenState is the state class for FetchWearingDataScreen.
  // It holds the state of the screen, including the _dataCollectionDevice, _hasFetchedData, _statusMessage, and _isSending variables.

  @override
  void initState() {
    super.initState();
    _dataCollectionDevice = _prepareDevice(widget
        .device); // In the initState method, the _dataCollectionDevice is prepared based on the selected device type,
    _hasFetchedData = _dataCollectionDevice.fetchData(
        context, // and _hasFetchedData is initialized by calling _dataCollectionDevice.fetchData.
        onDeviceConnected:
            _onDeviceConnected); //The _statusMessage is set to an initial message.

    final texts = LocaleText.of(context, listen: false);
    _statusMessage = texts.connectingToDevice;
  }

  DataCollectionDevice _prepareDevice(AvailableDevices type) {
    if (type == AvailableDevices.blueMaestroBle) {
      return BlueMaestroDevice();
    } else if (type == AvailableDevices.blueMaestroBleMock) {
      return BlueMaestroDevice(useMock: true, numberOfSimulatedHours: 10);
    } else if (type == AvailableDevices.simulated) {
      return SimulatedTemperatureDevice(
          frequency: 2, numberOfSimulatedHours: 100);
    } else {
      throw 'Unrecognized device';
    }
  }

  void _sendToDatabase(
      // _sendToDatabase is a private method that sends the collected data to a database.
      BuildContext context,
      DataCollectionDevice device) async {
    _isSending = true;
    final texts = LocaleText.of(context, listen: false);

    // Fetch the data and send to the database
    final wear = WearingTimeList();
    final period = 60 ~/ device.frequency;
    for (final data in device.data) {
      wear.add(WearingTime(
          //It constructs a WearingTimeList based on the collected data and sends it to the database.
          data.date,
          Duration(minutes: data.isBraceOn ? period : 0),
          id: data.id));
    }
    PatientDataList.of(context).addWearingTimeList(context, wear);

    // Patiently wait the database confirms the data were received
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _statusMessage = texts
            .sendingToDatabase; //It then waits for confirmation from the database and updates the _statusMessage accordingly.
      });
    });

    while (true) {
      if (!mounted) break;

      try {
        final dataTest = PatientDataList.of(context).myData(context);

        if (dataTest.wearingData.isNotEmpty &&
            (device.data.isEmpty ||
                dataTest.wearingData.any((e) => e.id == device.data[0].id))) {
          // Now that we know the data were sent, we can erase them from the
          // device
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if (mounted) {
              setState(() => _statusMessage = texts.finalizingDataCollection);
            }
          });

          break;
        }
      } on StateError {
        // This means the data are not there yet, we still have to wait for them
      }
      await Future.delayed(const Duration(milliseconds: 100));
    }

    if (mounted) {
      await device.clear(context);
    }

    // Wait a final frame to push the next page
    Future.microtask(
        () => Navigator.of(context).popAndPushNamed(widget.nextRoute));
  }

  void _onDeviceConnected() {
    // _onDeviceConnected is a callback method that is called when the device is connected.
    final texts = LocaleText.of(context, listen: false);
    _statusMessage = texts.collectingData;
    setState(
        () {}); //It updates the _statusMessage to indicate that data collection is in progress.
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // In the build method, a FutureBuilder is used to wait for _hasFetchedData.
      future: _hasFetchedData,
      builder: (context, data) {
        if (data.hasData && !_isSending) {
          // Once data is available and _isSending is not true, _sendToDatabase is called.
          _sendToDatabase(context, _dataCollectionDevice);
        }
        return Scaffold(
          // The widget displays a purple background with a rotating status message (using Transform.rotate)
          body: Container(
            decoration: const BoxDecoration(color: Colors.purple),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: -pi / 20,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _statusMessage,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CircularProgressIndicator(
                    //  a loading indicator while the data is being processed.
                    color: Colors.amber,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
