import 'package:common_lib/models/database.dart';
import 'package:common_lib/models/mood.dart';
import 'package:common_lib/models/wearing_time.dart';
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
    try {
      return firstWhere((element) => element.id == currentUser.id);
    } on StateError {
      final patient = PatientData(currentUser);
      add(patient);
      return patient;
    }
  }

  void addMood(BuildContext context, Mood mood) {
    final data = myData(context);
    data.moodData.add(mood);
    add(data);
  }

  void addMoodList(BuildContext context, List<Mood> moodList) {
    final data = myData(context);
    for (final mood in moodList) {
      data.moodData.add(mood);
    }
    add(data);
  }

  void addWearingTime(BuildContext context, WearingTime wear) {
    final data = myData(context);
    data.wearingData.add(wear);
    add(data);
  }

  void addWearingTimeList(BuildContext context, List<WearingTime> wearList) {
    final data = myData(context);
    for (final wear in wearList) {
      data.wearingData.add(wear);
    }
    add(data);
  }
}
