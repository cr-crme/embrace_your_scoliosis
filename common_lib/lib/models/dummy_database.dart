import 'dart:math';

import 'package:common_lib/models/enums.dart';
import 'package:common_lib/models/main_user.dart';
import 'package:common_lib/models/mood.dart';
import 'package:common_lib/models/patient_data.dart';
import 'package:common_lib/models/patient_data_list.dart';
import 'package:common_lib/models/wearing_time.dart';
import 'package:ezlogin/ezlogin.dart';

Map<String, dynamic> dummyInitialDatabase({
  int nbWearingDataPoints = 51,
  int nbMoodDataPoints = 30,
}) {
  // Create all the users
  final users = {
    'clinician@user.qc': userForEzloginMock(
        user: MainUser(
          firstName: 'Clinician',
          lastName: 'One',
          userType: UserType.clinician,
          email: 'clinician@user.qc',
          shouldChangePassword: false,
        ),
        password: '123456'),
    'first1@user.qc': userForEzloginMock(
        user: MainUser(
          firstName: 'Robert G Sauvé Larivière Joyal Tremblay Noël Beauchamps',
          lastName: 'Girard',
          email: 'first1@user.qc',
          shouldChangePassword: false,
          userType: UserType.patient,
        ),
        password: '123456'),
  };
  for (int i = 2; i < 20; i++) {
    users.addAll({
      'first$i@user.qc': userForEzloginMock(
          user: MainUser(
            firstName: 'User',
            lastName: '#$i',
            email: 'first$i@user.qc',
            shouldChangePassword: false,
            userType: UserType.patient,
          ),
          password: '123456'),
    });
  }

  // Populate them with data
  final rand = Random();
  final patientList = PatientDataList();
  for (final key in users.keys) {
    final current = users[key]!["user"] as MainUser;
    if (current.userType == UserType.clinician) continue;

    final patient = PatientData(current);
    final isAGoodWearer = rand.nextInt(3);
    double durationOffset = isAGoodWearer.toDouble() - 0.5;

    // Add some wearing data points
    for (int i = 0; i < nbWearingDataPoints; i++) {
      patient.wearingData.add(
        WearingTime(
          DateTime.now()
              .subtract(Duration(minutes: 30 * (nbWearingDataPoints - i))),
          Duration(
              minutes: rand.nextDouble() + durationOffset > 0.5 &&
                      i != nbWearingDataPoints - 1
                  ? 30
                  : 0),
        ),
      );
    }

    // Add some mood data points
    final happyLevel = rand.nextInt(5).toDouble() - 2.5;
    for (int i = 0; i < nbMoodDataPoints; i++) {
      patient.moodData.add(
        Mood(
          DateTime.now().subtract(Duration(days: nbMoodDataPoints - i - 1)),
          emotion:
              MoodDataLevelPath.fromDouble(rand.nextInt(5) + 1 + happyLevel),
          comfort:
              MoodDataLevelPath.fromDouble(rand.nextInt(5) + 1 + happyLevel),
          humidity:
              MoodDataLevelPath.fromDouble(rand.nextInt(5) + 1 + happyLevel),
          autonomy:
              MoodDataLevelPath.fromDouble(rand.nextInt(5) + 1 + happyLevel),
        ),
      );
    }

    patientList.add(patient);
  }

  return {'users': users, 'patients': patientList};
}
