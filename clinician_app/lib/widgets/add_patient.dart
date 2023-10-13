// This widget appears to represent an interface for adding new patients to a medical or healthcare-related application.
// It displays a container with an "Add" button,
// and when the button is pressed, it opens a dialog for adding patient information and updates the database and patient data accordingly.

import 'package:auto_size_text/auto_size_text.dart';
import 'package:clinician_app/widgets/new_patient_dialog.dart';
import 'package:common_lib/models/database.dart';
import 'package:common_lib/models/locale_text.dart';
import 'package:common_lib/models/main_user.dart';
import 'package:common_lib/models/patient_data.dart';
import 'package:common_lib/models/patient_data_list.dart';
import 'package:flutter/material.dart';
// It imports the necessary Flutter and custom widget libraries.

class AddPatient extends StatelessWidget {
  //The AddPatient widget is a stateless widget, that doesn't have mutable state.
  const AddPatient({Key? key, required this.height, required this.width})
      : super(
            key:
                key); //the construtor takes 2 required elements define below : height and width

// definition of those two elements
  final double height;
  final double width;

  void _addPatient(BuildContext context) async {
    // this method will be used to andle the logic for adding a new patient
    final database = Database.of(context);
    final patientData = PatientDataList.of(context);

    final newUser = await showDialog<MainUser>(
        //Displays a dialog for adding a new patient using the NewPatientDialog widget
        context: context,
        builder: (ctx) => const NewPatientDialog());
    if (newUser == null) return;

    await database.addUser(
        newUser: newUser, password: 'scoliosis'); // and waits for user input.
    patientData.add(PatientData(newUser));
  }

  @override
  Widget build(BuildContext context) {
    final texts = LocaleText.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          //This container is the main visual element of the AddPatient widget.
          height: height, // with a specified height and width,
          width: width,
          decoration: BoxDecoration(
              //  decorated with a border and rounded corners.
              border: Border.all(
                color: Colors.blue,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                texts
                    .addNewPatient, // widget displaying some text refered as addNewPatien
                textAlign: TextAlign.center,
                style: Theme.of(context) //styling option for the text
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.blue),
              ),
              const SizedBox(
                  height:
                      8), // this sizedBox is used to make some space between the text and the button
              IconButton(
                onPressed: () => _addPatient(
                    context), // when that icon is pressed it's adding a patient
                iconSize: width / 6, // define the size of the icon
                icon: const Icon(
                  Icons
                      .add_circle, // the button is an icon whic is an add_cercle
                  color: Colors.blue, // its color is blue
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
