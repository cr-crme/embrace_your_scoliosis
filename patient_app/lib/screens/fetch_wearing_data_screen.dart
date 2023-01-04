import 'dart:math';

import 'package:common_lib/models/patient_data_list.dart';
import 'package:common_lib/models/wearing_time.dart';
import 'package:common_lib/models/locale_text.dart';
import 'package:common_lib/models/wearing_time_list.dart';
import 'package:flutter/material.dart';

import '/data_collection_devices/data_collection_devices.dart';
import '/data_collection_devices/devices/available_devices.dart';

class FetchWearingDataScreen extends StatefulWidget {
  const FetchWearingDataScreen({
    super.key,
    required this.device,
    required this.nextRoute,
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

  @override
  void initState() {
    super.initState();
    _dataCollectionDevice = _prepareDevice(widget.device);
    _hasFetchedData = _dataCollectionDevice.fetchData(context,
        onDeviceConnected: _onDeviceConnected);

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
      BuildContext context, DataCollectionDevice device) async {
    final texts = LocaleText.of(context, listen: false);

    // Fetch the data and send to the database
    final wear = WearingTimeList();
    final period = 60 ~/ device.frequency;
    for (final data in device.data) {
      wear.add(WearingTime(
          data.date, Duration(minutes: data.isBraceOn ? period : 0),
          id: data.id));
    }
    PatientDataList.of(context).addWearingTimeList(context, wear);

    // Patiently wait the database confirms the data were received
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _statusMessage = texts.sendingToDatabase;
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
          await device.clear(context);
          break;
        }
      } on StateError {
        // This means the data are not there yet, we still have to wait for them
      }
      await Future.delayed(const Duration(milliseconds: 100));
    }

    // Wait a final frame to push the next page
    Future.microtask(
        () => Navigator.of(context).popAndPushNamed(widget.nextRoute));
  }

  void _onDeviceConnected() {
    final texts = LocaleText.of(context, listen: false);
    _statusMessage = texts.collectingData;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _hasFetchedData,
      builder: (context, data) {
        if (data.hasData) {
          _sendToDatabase(context, _dataCollectionDevice);
        }
        return Scaffold(
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
                              .headline5!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CircularProgressIndicator(
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
