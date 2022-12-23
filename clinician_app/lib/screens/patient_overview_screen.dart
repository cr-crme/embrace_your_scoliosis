import 'package:common_lib/models/database.dart';
import 'package:common_lib/models/enums.dart';
import 'package:common_lib/models/patient_data_list.dart';
import 'package:common_lib/models/locale_text.dart';
import 'package:flutter/material.dart';

import '/widgets/patient_overview.dart';
import '/widgets/add_patient.dart';

class PatientOverviewScreen extends StatelessWidget {
  const PatientOverviewScreen({super.key});

  static const String routeName = '/patient-overview-screen';

  @override
  Widget build(BuildContext context) {
    final texts = LocaleText.of(context);
    final windowWidth = MediaQuery.of(context).size.width;
    final width = windowWidth >= 600 ? 200.0 : windowWidth / 3;
    final height = width * 3 / 2;

    final database = Database.of(context);
    if (database.currentUser!.userType != UserType.clinician) {
      return Scaffold(
        body: Center(child: Text(texts.notLicenced)),
      );
    }
    final patients = PatientDataList.of(context, listen: true);

    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: height + 10,
              crossAxisSpacing: 10),
          itemBuilder: (ctx, index) {
            if (index != patients.length) {
              return PatientOverview(
                patients[index],
                width: width,
                height: height,
              );
            } else {
              return AddPatient(height: height, width: width);
            }
          },
          itemCount: patients.length + 1,
        ),
      )),
    );
  }
}
