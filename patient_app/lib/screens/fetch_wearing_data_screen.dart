import 'dart:math';

import 'package:common_lib/models/patient_data_list.dart';
import 'package:common_lib/models/wearing_time.dart';
import 'package:common_lib/models/locale_text.dart';
import 'package:common_lib/models/wearing_time_list.dart';
import 'package:flutter/material.dart';

import '/data_collection_devices/data_collection_devices.dart';
import '/data_collection_devices/devices/available_devices.dart';
import '/screens/home_screen.dart';

class FetchWearingDataScreen extends StatelessWidget {
  const FetchWearingDataScreen({
    super.key,
    required this.device,
  });

  static const String routeName = '/fetch-data-screen';
  final AvailableDevices device;

  DataCollectionDevice _prepareDevice(AvailableDevices type) {
    if (type == AvailableDevices.blueMaestroBle) {
      return BlueMaestroDevice();
    } else if (type == AvailableDevices.blueMaestroBleMock) {
      return BlueMaestroDevice(useMock: true, numberOfSimulatedHours: 100);
    } else if (type == AvailableDevices.simulated) {
      return SimulatedTemperatureDevice(
          frequency: 2, numberOfSimulatedHours: 100);
    } else {
      throw 'Unrecognized device';
    }
  }

  void _sendDataFromDevice(
      BuildContext context, DataCollectionDevice device) async {
    final wear = WearingTimeList();
    final period = 60 ~/ device.frequency;
    for (final data in device.data) {
      wear.add(WearingTime(
          data.date, Duration(minutes: data.isBraceOn ? period : 0)));
    }

    PatientDataList.of(context).addWearingTimeList(context, wear);

    await device.clear(context);

    Future.microtask(
        () => Navigator.of(context).popAndPushNamed(HomeScreen.routeName));
  }

  @override
  Widget build(BuildContext context) {
    final texts = LocaleText.of(context);
    final device = _prepareDevice(AvailableDevices.blueMaestroBleMock);

    return FutureBuilder(
      future: device.fetchData(context),
      builder: (context, data) {
        if (data.hasData) {
          _sendDataFromDevice(context, device);
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
                          texts.fetchingAndSedingData,
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
