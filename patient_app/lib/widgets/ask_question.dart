// The AskQuestions widget provides a patient-friendly interface for users to interact with healthcare-related actions,
// such as asking questions, making calls, or scheduling appointments.
// You can implement the functionality for initiating calls and scheduling appointments as needed in the call and rdv methods.

import 'package:flutter/material.dart';
import 'package:patient_app/widgets/text_question.dart';

class AskQuestions extends StatefulWidget {
  // stateful widget responsible for creating a client interface
  const AskQuestions({super.key});

  @override
  State<AskQuestions> createState() {
    return _AskQuestions();
  }
}

// faire une fonction du genre selected qu'il y a dans mood_questionnaire

class _AskQuestions extends State<AskQuestions> {
  void _openQuestionOverlay() {
    //  open a modal bottom sheet that displays a text input field for users to ask questions or provide remarks.
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const TextQuestions(),
    );
  }

// These methods are placeholders for actions related to initiating a call and scheduling an appointment.
// They are currently empty
  void call() {
    setState(() {});
  }

  void rdv() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: (LinearGradient(
          colors: [
            Color.fromARGB(255, 78, 13, 151),
            Color.fromARGB(255, 107, 15, 168),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton.icon(
              // Asking questions or providing remarks.
              onPressed: _openQuestionOverlay,
              icon: const Icon(Icons.arrow_right_alt),
              label: const Text(
                'Do you have any question or a remark to share',
                style: TextStyle(
                  color: Color.fromARGB(255, 237, 223, 252),
                  fontSize: 15,
                ),
              ),
            ),
            OutlinedButton.icon(
              // Initiating a call.
              onPressed: call,
              //changeColor,
              icon: const Icon(Icons.add_call),
              label: const Text(
                'Do you want to give us a call',
                style: TextStyle(
                  color: Color.fromARGB(255, 237, 223, 252),
                  fontSize: 15,
                ),
              ),
            ),
            OutlinedButton.icon(
              // Scheduling an appointment.
              onPressed: rdv,
              icon: const Icon(Icons.accessibility_new),
              label: const Text(
                'Do you want to schedule an appointment',
                style: TextStyle(
                  color: Color.fromARGB(255, 237, 223, 252),
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
