import 'package:common_lib/models/database.dart';
import 'package:common_lib/models/mood.dart';
import 'package:common_lib/models/wearing_time.dart';
import 'package:enhanced_containers/enhanced_containers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'patient_data.dart';

class PatientDataList extends ListProvided<PatientData> {
  @override
  PatientData deserializeItem(data) => PatientData.fromSerialized(data);

  static PatientDataList of(BuildContext context, {bool listen = false}) =>
      Provider.of<PatientDataList>(context, listen: listen);

  PatientData myData(BuildContext context, {notify = true}) {
    final currentUser = Database.of(context).currentUser!;
    try {
      return firstWhere((element) => element.userId == currentUser.email);
    } on StateError {
      add(PatientData(currentUser), notify: notify);
      return last;
    }
  }

  void addMood(BuildContext context, Mood mood, {notify = true}) {
    final data = myData(context, notify: false);
    data.moodData.add(mood);
    if (notify) notifyListeners();
  }

  void addMoodList(BuildContext context, List<Mood> moodList, {notify = true}) {
    final data = myData(context, notify: false);
    for (final mood in moodList) {
      data.moodData.add(mood);
    }
    if (notify) notifyListeners();
  }

  void addWearingTime(BuildContext context, WearingTime wear, {notify = true}) {
    final data = myData(context, notify: false);
    data.wearingData.add(wear);
    if (notify) notifyListeners();
  }

  void addWearingTimeList(BuildContext context, List<WearingTime> wearList,
      {notify = true}) {
    final data = myData(context, notify: false);
    for (final wear in wearList) {
      data.wearingData.add(wear);
    }
    if (notify) notifyListeners();
  }
}
