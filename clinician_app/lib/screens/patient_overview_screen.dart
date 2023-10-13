import 'package:common_lib/models/database.dart';
import 'package:common_lib/models/enums.dart';
import 'package:common_lib/models/patient_data_list.dart';
import 'package:common_lib/models/locale_text.dart';
import 'package:flutter/material.dart';

import '/widgets/patient_overview.dart';
import '/widgets/add_patient.dart';

class PatientOverviewScreen extends StatelessWidget {
  //The PatientOverviewScreen widget is a stateless widget, that doesn't have mutable state.
  const PatientOverviewScreen({super.key});

  static const String routeName =
      '/patient-overview-screen'; // The LoginScreen widget defines a static constant routeName with the value '/patient-overview-screen'.

  @override
  Widget build(BuildContext context) {
    final texts = LocaleText.of(context);
    final windowWidth = MediaQuery.of(context).size.width;
    final width = windowWidth >= 600 ? 200.0 : windowWidth / 2;
    final height = width * 3 / 2;

    final database = Database.of(context);
    if (database.currentUser!.userType != UserType.clinician) {
      return Scaffold(
        body: Center(
            child: Text(texts
                .notLicenced)), // if the user is not the cliniance it will return a text saying that he isn't referenced int the database
      );
    }
    final patients = PatientDataList.of(context, listen: true);

    return Scaffold(
      body: Center(
          child: Padding(
        //padding allows to have a separation between each patient file
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          // GridView is the widget which allows us to put several patient on the same raw
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              // grid with an infinite number of cases
              crossAxisCount: 2, // two patients for each row
              mainAxisExtent: height + 10,
              crossAxisSpacing: 10), // space between each column
          itemBuilder: (ctx, index) {
            if (index != patients.length) {
              return PatientOverview(
                patients[index],
                width: width,
                height: height,
              );
            } else {
              return AddPatient(
                  height: height,
                  width:
                      width); // return the file add_patient where the styling is already done
            }
          },
          itemCount: patients.length + 1,
        ),
      )),
    );
  }
}
