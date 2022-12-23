import 'package:enhanced_containers/enhanced_containers.dart';

import 'enums.dart';
import 'mood_list.dart';

class Mood extends ItemSerializable {
  DateTime date;
  MoodDataLevel emotion;
  MoodDataLevel comfort;
  MoodDataLevel humidity;
  MoodDataLevel autonomy;

  Mood(
    this.date, {
    this.emotion = MoodDataLevel.none,
    this.comfort = MoodDataLevel.none,
    this.humidity = MoodDataLevel.none,
    this.autonomy = MoodDataLevel.none,
    super.id,
  });

  Mood copyWith({
    DateTime? date,
    MoodDataLevel? emotion,
    MoodDataLevel? comfort,
    MoodDataLevel? humidity,
    MoodDataLevel? autonomy,
  }) {
    return Mood(
      date ?? this.date,
      emotion: emotion ?? this.emotion,
      comfort: comfort ?? this.comfort,
      humidity: humidity ?? this.humidity,
      autonomy: autonomy ?? this.autonomy,
      id: id,
    );
  }

  factory Mood.fromList(MoodList lst) {
    if (lst.isEmpty) {
      return Mood(DateTime.now(),
          emotion: MoodDataLevel.none,
          comfort: MoodDataLevel.none,
          humidity: MoodDataLevel.none,
          autonomy: MoodDataLevel.none);
    }

    final meanEmotion =
        lst.fold(0, (prev, e) => prev + e.emotion.index) / lst.length;
    final meanComfort =
        lst.fold(0, (prev, e) => prev + e.comfort.index) / lst.length;
    final meanHumidity =
        lst.fold(0, (prev, e) => prev + e.humidity.index) / lst.length;
    final meanAutonomy =
        lst.fold(0, (prev, e) => prev + e.autonomy.index) / lst.length;

    return Mood(
      DateTime.now(),
      emotion: MoodDataLevelPath.fromDouble(meanEmotion),
      comfort: MoodDataLevelPath.fromDouble(meanComfort),
      humidity: MoodDataLevelPath.fromDouble(meanHumidity),
      autonomy: MoodDataLevelPath.fromDouble(meanAutonomy),
    );
  }

  /// This is how the [serializeMap] of the [MoodDataPoint] looks like
  @override
  Map<String, dynamic> serializedMap() => {
        'date': date.millisecondsSinceEpoch ~/ 1000 ~/ 60,
        'emotion': emotion.index,
        'comfort': comfort.index,
        'humidity': humidity.index,
        'autonomy': autonomy.index,
      };

  Mood.deserialize(map)
      : date = DateTime.fromMillisecondsSinceEpoch(map['date'] * 60 * 1000),
        emotion = MoodDataLevel.values[map['emotion']],
        comfort = MoodDataLevel.values[map['comfort']],
        humidity = MoodDataLevel.values[map['humidity']],
        autonomy = MoodDataLevel.values[map['autonomy']],
        super.fromSerialized(map);

  bool get hasVeryBad =>
      emotion == MoodDataLevel.veryBad ||
      comfort == MoodDataLevel.veryBad ||
      humidity == MoodDataLevel.veryBad ||
      autonomy == MoodDataLevel.veryBad;

  bool get isSet {
    return emotion != MoodDataLevel.none &&
        comfort != MoodDataLevel.none &&
        humidity != MoodDataLevel.none &&
        autonomy != MoodDataLevel.none;
  }

  @override
  String toString() =>
      'Emotion: $emotion, Comfort: $comfort, Humidity: $humidity, Autonony: $autonomy';
}
