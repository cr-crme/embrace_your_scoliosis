import 'package:enhanced_containers/enhanced_containers.dart';

import 'main_user.dart';
import 'mood_list.dart';
import 'wearing_time_list.dart';

class PatientData extends ItemSerializable {
  final WearingTimeList wearingData;
  final MoodList moodData;
  final String userId;

  PatientData(MainUser user)
      : wearingData = WearingTimeList(),
        moodData = MoodList(),
        userId = user.email;

  PatientData.fromSerialized(map)
      : wearingData = WearingTimeList.fromSerialized(map['wearing']),
        moodData = MoodList.fromSerialized(map['mood']),
        userId = map['id'];

  @override
  Map<String, dynamic> serializedMap() => {
        'wearing': wearingData.serialize(),
        'mood': moodData.serialize(),
        'id': userId,
      };
}
