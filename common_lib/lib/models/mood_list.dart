import 'package:enhanced_containers/enhanced_containers.dart';

import 'mood.dart';

class MoodList extends ListSerializable<Mood> {
  @override
  Mood deserializeItem(data) => Mood.deserialize(data);

  MoodList();
  MoodList.fromSerialized(map) : super.fromSerialized(map);

  Mood get mean => Mood.fromList(this);

  MoodList getFrom({required DateTime from, DateTime? to}) {
    to ??= DateTime.now();

    MoodList out = MoodList();
    forEach((e) {
      if (e.date.compareTo(from) >= 0 && e.date.compareTo(to!) < 0) {
        out.add(e);
      }
    });
    return out;
  }

  bool get hasVeryBad {
    return indexWhere((element) => element.hasVeryBad) >= 0;
  }
}
