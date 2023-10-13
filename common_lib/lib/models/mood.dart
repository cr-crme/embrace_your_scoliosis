import 'package:enhanced_containers/enhanced_containers.dart';

import 'enums.dart';
import 'mood_list.dart';

class Mood extends ItemSerializable {
  DateTime date; // Represents the date and time of the mood data.
  MoodDataLevel emotion; // Represents the mood level related to emotion.
  MoodDataLevel comfort; // Represents the mood level related to comfort.
  MoodDataLevel humidity; // Represents the mood level related to humidity.
  MoodDataLevel autonomy; // Represents the mood level related to autonomy.

  Mood(
    // Constructor initializes the Mood object with provided attributes.
    this.date, {
    this.emotion = MoodDataLevel.none,
    this.comfort = MoodDataLevel.none,
    this.humidity = MoodDataLevel.none,
    this.autonomy = MoodDataLevel.none,
    super.id,
  });

  Mood copyWith({
    // Method to create a copy of the Mood object with optional attribute changes.
    DateTime? date,
    MoodDataLevel? emotion,
    MoodDataLevel? comfort,
    MoodDataLevel? humidity,
    MoodDataLevel? autonomy,
  }) {
    return Mood(
      // Create a new Mood object with provided or existing attribute values.
      date ?? this.date,
      emotion: emotion ?? this.emotion,
      comfort: comfort ?? this.comfort,
      humidity: humidity ?? this.humidity,
      autonomy: autonomy ?? this.autonomy,
      id: id,
    );
  }

  factory Mood.fromList(MoodList lst) {
    // Factory method calculates and returns a new Mood object based on a list of Mood objects.
    if (lst.isEmpty) {
      return Mood(DateTime.now(),
          emotion: MoodDataLevel.none,
          comfort: MoodDataLevel.none,
          humidity: MoodDataLevel.none,
          autonomy: MoodDataLevel.none);
    }
// Calculate the mean mood levels for emotion, comfort, humidity, and autonomy
    final meanEmotion =
        lst.fold(0, (prev, e) => prev + e.emotion.index) / lst.length;
    final meanComfort =
        lst.fold(0, (prev, e) => prev + e.comfort.index) / lst.length;
    final meanHumidity =
        lst.fold(0, (prev, e) => prev + e.humidity.index) / lst.length;
    final meanAutonomy =
        lst.fold(0, (prev, e) => prev + e.autonomy.index) / lst.length;

    return Mood(
      // Create a new Mood object with the calculated mean mood levels.
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

  Mood.deserialize(
      map) // / Constructor to create a Mood object by deserializing a map.
      : date = DateTime.fromMillisecondsSinceEpoch(map['date'] * 60 * 1000),
        emotion = MoodDataLevel.values[map['emotion']],
        comfort = MoodDataLevel.values[map['comfort']],
        humidity = MoodDataLevel.values[map['humidity']],
        autonomy = MoodDataLevel.values[map['autonomy']],
        super.fromSerialized(map);

  bool
      get hasVeryBad => // Property to check if any of the mood levels is set to "very bad."
          emotion == MoodDataLevel.veryBad ||
          comfort == MoodDataLevel.veryBad ||
          humidity == MoodDataLevel.veryBad ||
          autonomy == MoodDataLevel.veryBad;

  bool get isSet {
    // Property to check if all mood levels are set to values other than "none."
    return emotion != MoodDataLevel.none &&
        comfort != MoodDataLevel.none &&
        humidity != MoodDataLevel.none &&
        autonomy != MoodDataLevel.none;
  }

  @override
  String toString() => // Method to provide a string representation of the Mood object.
      'Emotion: $emotion, Comfort: $comfort, Humidity: $humidity, Autonony: $autonomy';
}
