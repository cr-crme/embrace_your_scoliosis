// This widget is used  to allow patients to input text-based questions, which can then be submitted or canceled.
// The entered text is cleared after submission, and the keyboard is dismissed.
// The final goal is to submit this question to the clinician app, by saving them in a server

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth
    .instance; // initialization of firebase authentification using firebase instance

class TextQuestions extends StatefulWidget {
  // stateful widget responsible for creating a text input field where patients can ask questions.
  const TextQuestions({super.key});

  @override
  State<TextQuestions> createState() {
    return _TextQuestions();
  }
}

class _TextQuestions extends State<TextQuestions> {
  // This state class manages the patient's interaction with the text input field.
  final questionControler =
      TextEditingController(); // is created to manage the text input field. This controller is used to save what the user writes.

  @override
  void dispose() {
    // is overridden to release resources when the widget is no longer in use. It disposes of the questionControler.
    questionControler.dispose();
    super.dispose();
  }

  void submitQuestion() {
    // This method is called when the patient submits a question.
    final enteredQuestion =
        questionControler.text; // It retrieves the text entered by the user

    if (enteredQuestion.trim().isEmpty) {
      return; //
    }
    // If the entered question is not empty, it clears the input field, unfocuses the keyboard
    questionControler.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            textCapitalization: TextCapitalization
                .sentences, // The first word of each sentence will begin will a capital letter
            autocorrect: true, // automatic correction is activated
            enableSuggestions: true, // no words suggestions
            controller: questionControler,
            maxLength: 100, // A maximum length of 100 characters is enforced
            decoration: const InputDecoration(
              label: Text('Ask us your question'),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  // when pressed, pops the current screen to remove the question input screen.
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed:
                    submitQuestion, //  when pressed, calls the submitQuestion method to handle question submission.
                // () {
                //   print(questionControler.text);
                //   Navigator.pop(context);
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(
                //       duration: Duration(
                //         seconds: 3,
                //       ),
                //       content: Center(
                //         child: Text(
                //           'question submit',
                //         ),
                //       ),
                //     ),
                //   );
                // },
                child: const Text('submit'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
