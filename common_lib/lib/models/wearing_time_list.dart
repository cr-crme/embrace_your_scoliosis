import 'package:enhanced_containers/enhanced_containers.dart';

import 'wearing_time.dart';

class WearingTimeList extends ListSerializable<WearingTime> {
  @override
  WearingTime deserializeItem(data) => throw UnimplementedError();

  WearingTimeList();
  WearingTimeList.fromSerialized(map) : super.fromSerialized(map);

  ///
  /// Returns the wearing time (in hours) associated with each data points
  List<double> get wearingTime =>
      map((e) => e.wearTime.inMinutes / 60).toList();

  WearingTimeList getFrom({required DateTime from, DateTime? to}) {
    to ??= DateTime.now();

    WearingTimeList out = WearingTimeList();
    forEach((e) {
      if (e.startingTime.compareTo(from) >= 0 &&
          e.startingTime.compareTo(to!) < 0) {
        out.add(e);
      }
    });
    return out;
  }

  ///
  /// Returns the earliest point acquired (independent of the list order)
  WearingTime get earliest => reduce((value, element) =>
      element.startingTime.isBefore(value.startingTime) ? element : value);

  ///
  /// Returns the latest point acquired (independent of the list order)
  WearingTime get latest => reduce((value, element) =>
      element.startingTime.isBefore(value.startingTime) ? value : element);

  ///
  /// Returns the total wearing time (in hours) of the scoliosis brace
  double get totalWearingTime =>
      fold(0, (runningSum, e) => runningSum + e.wearTime.inMinutes) / 60;

  ///
  /// Returns the mean wearing time per day of the scoliosis brace
  double get meanWearingTimePerDay => isEmpty
      ? 0
      : totalWearingTime /
          (latest.startingTime
                  .difference(earliest.startingTime)
                  .inHours
                  .toDouble() /
              24);
}
