import 'dart:math';

enum MoodDataLevel { none, veryBad, poor, medium, good, excellent }

num _clamp(num number, num low, num high) =>
    max(low * 1.0, min(number * 1.0, high * 1.0));

extension MoodDataLevelPath on MoodDataLevel {
  static MoodDataLevel fromDouble(value) {
    return MoodDataLevel.values[_clamp(value, 0, 5).round()];
  }

  String get path {
    switch (this) {
      case MoodDataLevel.excellent:
        return 'assets/excellent.png';
      case MoodDataLevel.good:
        return 'assets/good.png';
      case MoodDataLevel.medium:
        return 'assets/medium.png';
      case MoodDataLevel.poor:
        return 'assets/poor.png';
      case MoodDataLevel.veryBad:
        return 'assets/veryBad.png';
      default:
        return '';
    }
  }
}

enum UserType { patient, clinician }
