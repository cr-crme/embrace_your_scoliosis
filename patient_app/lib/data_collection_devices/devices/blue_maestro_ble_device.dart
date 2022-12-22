import 'package:blue_maestro_ble/blue_maestro_ble.dart';
import 'package:flutter/material.dart';

import '../data/blue_maestro_ble_data_point.dart';
import 'data_collection_device.dart';

class BlueMaestroDevice extends DataCollectionDevice {
  final BlueMaestroBle device;
  bool _isInitialized = false;

  BlueMaestroDevice({bool useMock = false, int numberOfSimulatedHours = 100})
      : device = useMock
            ? BlueMaestroMock(numberMeasurements: numberOfSimulatedHours)
            : BlueMaestroBle(),
        super(frequency: 1);

  void _manageLogAllResponse(
      BuildContext context, BlueMaestroResponse response) {
    data.clear();

    final measures = response.asMeasurements();
    if (measures == null) return;

    final firstTimeStamp = DateTime.now().subtract(
        Duration(minutes: measures.temperature.length * (60 ~/ frequency)));
    for (var i = 0; i < measures.temperature.length; i++) {
      final timeStamp =
          firstTimeStamp.add(Duration(minutes: i * (60 ~/ frequency)));
      data.add(
          BlueMaestroBleDataPoint(measures.temperature[i], date: timeStamp));
    }
  }

  Future<BleStatusCode> _requestData(BuildContext context) async {
    if (!_isInitialized) {
      final status = await device.initialize(maximumRetries: 10);
      if (status != BleStatusCode.success) return status;
    }
    _isInitialized = true;

    final status = await device.transmitWithResponse(
        BlueMaestroCommand.logAll(),
        onResponse: (response) => _manageLogAllResponse(context, response));
    if (status != BleStatusCode.success) return status;

    return BleStatusCode.success;
  }

  @override
  Future<bool> fetchData(BuildContext context, {notify = false}) async {
    if (data.isNotEmpty) return true;

    final status = await _requestData(context);
    if (status != BleStatusCode.success) return false;

    return true;
  }

  @override
  Future<bool> clear(BuildContext context) async {
    if (data.isEmpty) return true;

    final status = await device.transmitWithResponse(
        BlueMaestroCommand.clearLog(),
        onResponse: (response) {});
    if (status != BleStatusCode.success) return false;

    data.clear();
    return true;
  }
}
