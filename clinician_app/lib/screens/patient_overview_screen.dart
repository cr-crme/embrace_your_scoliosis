import 'package:common_lib/models/database.dart';
import 'package:common_lib/models/enums.dart';
import 'package:common_lib/models/patient_data_list.dart';
import 'package:common_lib/models/locale_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/widgets/patient_overview.dart';

class PatientOverviewScreen extends StatelessWidget {
  const PatientOverviewScreen({super.key});

  static const String routeName = '/patient-overview-screen';

  @override
  Widget build(BuildContext context) {
    final texts = LocaleText.of(context);
    final windowWidth = MediaQuery.of(context).size.width;
    final width = windowWidth >= 600 ? 200.0 : windowWidth / 3;
    final height = width * 3 / 2;

    final database = Provider.of<Database>(context, listen: false);
    if (database.currentUser!.userType != UserType.clinician) {
      return Scaffold(
        body: Center(child: Text(texts.notLicenced)),
      );
    }
    final patients = Provider.of<PatientDataList>(context, listen: false);

    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: height + 10,
              crossAxisSpacing: 10),
          itemBuilder: (ctx, index) => PatientOverview(
            patients[index],
            width: width,
            height: height,
          ),
          itemCount: patients.length,
        ),
      )),
    );
  }
}
