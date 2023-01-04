import 'package:common_lib/models/database.dart';
import 'package:common_lib/models/mood.dart';
import 'package:common_lib/models/mood_list.dart';
import 'package:common_lib/models/wearing_time.dart';
import 'package:common_lib/models/wearing_time_list.dart';
import 'package:enhanced_containers/enhanced_containers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'patient_data.dart';

class PatientDataList extends FirebaseListProvided<PatientData> {
  PatientDataList({super.pathToData = 'patients'});

  @override
  PatientData deserializeItem(data) => PatientData.fromSerialized(data);

  static PatientDataList of(BuildContext context, {bool listen = false}) =>
      Provider.of<PatientDataList>(context, listen: listen);

  PatientData myData(BuildContext context) {
    final currentUser = Database.of(context).currentUser!;
    return firstWhere((element) => element.id == currentUser.id);
  }

  void addMood(BuildContext context, Mood mood) {
    final currentUser = Database.of(context).currentUser!;
    final moodList = MoodList();
    moodList.add(mood);
    insertInList('${currentUser.id}/mood', moodList);
  }

  void addMoodList(BuildContext context, MoodList moodList) {
    final currentUser = Database.of(context).currentUser!;
    insertInList('${currentUser.id}/mood', moodList);
  }

  void addWearingTime(BuildContext context, WearingTime wear) {
    final currentUser = Database.of(context).currentUser!;
    final wearList = WearingTimeList();
    wearList.add(wear);
    insertInList('${currentUser.id}/wearing', wearList);
  }

  void addWearingTimeList(BuildContext context, WearingTimeList wearList) {
    final currentUser = Database.of(context).currentUser!;
    insertInList('${currentUser.id}/wearing', wearList);
  }
}
