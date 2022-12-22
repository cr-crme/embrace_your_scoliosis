import 'package:enhanced_containers/enhanced_containers.dart';

class WearingTime extends ItemSerializable {
  /// This class is the clinician side of the [DataPoint] class of the patient
  /// side. It should be able to deserialize the latter class to provide a
  /// wearing time.

  final DateTime startingTime;
  final Duration wearTime;

  WearingTime(this.startingTime, this.wearTime);

  WearingTime.deserialize(map)
      : startingTime = map['date'],
        wearTime = Duration(minutes: map['wear']);

  @override
  Map<String, dynamic> serializedMap() {
    /// This what the serializeMap should look like in the patient side
    return {
      'date': startingTime.millisecondsSinceEpoch ~/ 1000 ~/ 60,
      'wear': wearTime.inMinutes,
    };
  }
}
