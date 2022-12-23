import 'package:auto_size_text/auto_size_text.dart';
import 'package:clinician_app/widgets/new_patient_dialog.dart';
import 'package:common_lib/models/database.dart';
import 'package:common_lib/models/locale_text.dart';
import 'package:common_lib/models/main_user.dart';
import 'package:common_lib/models/patient_data.dart';
import 'package:common_lib/models/patient_data_list.dart';
import 'package:flutter/material.dart';

class AddPatient extends StatelessWidget {
  const AddPatient({Key? key, required this.height, required this.width})
      : super(key: key);

  final double height;
  final double width;

  void _addPatient(BuildContext context) async {
    final database = Database.of(context);
    final patientData = PatientDataList.of(context);

    final newUser = await showDialog<MainUser>(
        context: context, builder: (ctx) => const NewPatientDialog());
    if (newUser == null) return;

    await database.addUser(newUser: newUser, password: 'scoliosis');
    patientData.add(PatientData(newUser));
  }

  @override
  Widget build(BuildContext context) {
    final texts = LocaleText.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                texts.addNewPatient,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.blue),
              ),
              const SizedBox(height: 8),
              IconButton(
                onPressed: () => _addPatient(context),
                iconSize: width / 6,
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
