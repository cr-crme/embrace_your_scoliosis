import 'ble_data_point.dart';

class BlueMaestroBleDataPoint extends BleDataPoint {
  BlueMaestroBleDataPoint(super.value, {super.date});

  static const double threshold = 25;

  @override
  bool get isBraceOn => value >= threshold;
}
