import 'dart:math';

import 'package:flutter/material.dart';

import '../data/blue_maestro_ble_data_point.dart';
import 'data_collection_device.dart';

class SimulatedTemperatureDevice extends DataCollectionDevice {
  bool hasData = false;
  final randomizer = Random(42);

  SimulatedTemperatureDevice({
    required super.frequency,
    this.variability = 2,
    this.numberOfSimulatedHours = 100,
  });
  final double variability;
  final int numberOfSimulatedHours;

  void simulateData({double offset = 0}) {
    final firstTimeStamp = DateTime.now().subtract(Duration(
        minutes: numberOfSimulatedHours * frequency + 1 * (60 ~/ frequency)));
    var runningTemperature = 25.0;
    for (int i = 0; i < numberOfSimulatedHours * frequency + 1; i++) {
      final timeStamp =
          firstTimeStamp.add(Duration(minutes: i * (60 ~/ frequency)));
      data.add(BlueMaestroBleDataPoint(runningTemperature, date: timeStamp));
      runningTemperature +=
          randomizer.nextDouble() * variability - (variability / 2) + offset;
    }
  }

  @override
  Future<bool> fetchData(BuildContext context, {notify = false}) async {
    if (data.isNotEmpty) return true;

    data.clear();
    simulateData();

    return true;
  }

  @override
  Future<bool> clear(BuildContext context) async {
    data.clear();
    return true;
  }
}
