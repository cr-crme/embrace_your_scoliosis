import 'package:enhanced_containers/enhanced_containers.dart';
import 'package:ezlogin/ezlogin.dart';

import 'main_user.dart';
import 'mood_list.dart';
import 'wearing_time_list.dart';

class PatientData extends ItemSerializable {
  final WearingTimeList wearingData;
  final MoodList moodData;

  PatientData(MainUser user)
      : wearingData = WearingTimeList(),
        moodData = MoodList(),
        super(id: emailToPath(user.email));
  //ajouter questiondata = nom de la classe que j'ai créée

  PatientData.fromSerialized(map)
      : wearingData = map != null && map['wearing'] != null
            ? WearingTimeList.fromSerialized(map['wearing'])
            : WearingTimeList(),
        moodData = map != null && map['mood'] != null
            ? MoodList.fromSerialized(map['mood'])
            : MoodList(),
        super.fromSerialized(map);

  @override
  Map<String, dynamic> serializedMap() => {
        'wearing': wearingData.serialize(),
        'mood': moodData.serialize(),
        'id': id,
      };
}
