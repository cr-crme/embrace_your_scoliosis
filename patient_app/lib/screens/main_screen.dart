// In summary, MainScreen is a central screen in patient app that displays mood-related content,
// including a pie chart, a mood questionnaire, and a section for asking questions.

import 'package:flutter/material.dart';
import 'package:patient_app/widgets/ask_question.dart';

import '/widgets/mood_pie.dart';
import '/widgets/mood_questionnaire.dart';

class MainScreen extends StatelessWidget {
  // MainScreen is a StatelessWidget representing the main screen of your app.
  const MainScreen({super.key});

  static const String routeName =
      '/main-screen'; // It's a constant string that defines a route name for this screen. It is used to navigate to this screen using the defined route name.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // // The use of SingleChildScrollView allows users to scroll through the content
// if it doesn't fit on the screen, ensuring a good user experience.
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const Center(
            child: Column(
              // this screen will be separeted in three columns
              mainAxisSize: MainAxisSize.min,
              children: [
                MoodPie(), // widget responsible for the moodpie
                MoodQuestionnaire(), // widget responsible for the Mood questionnaire that the patient could answer every day
                Expanded(
                    child:
                        AskQuestions()), // widget responsible for a needed call, RDV or question
              ],
            ),
          ),
        ),
      ),
    );
  }
}
