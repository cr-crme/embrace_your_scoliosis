import '../data/ble_data_point.dart';
import 'package:flutter/material.dart';

abstract class DataCollectionDevice {
  DataCollectionDevice({required this.frequency});

  final List<BleDataPoint> data = [];

  ///
  /// Data acquisition frequency in data per hour
  final int frequency;

  ///
  /// This method fetches a new data point to the device, adds it to the data
  /// list and returns if it was a success or not.
  Future<bool> fetchData(BuildContext context, {notify = false});

  ///
  /// Once the data are aquired, one must clear the data in the device so they
  /// are not added twice.
  Future<bool> clear(BuildContext context);
}
