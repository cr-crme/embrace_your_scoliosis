import 'package:flutter/material.dart';

import '/widgets/mood_pie.dart';
import '/widgets/mood_questionnaire.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const String routeName = '/main-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const Center(
            child: Column(
              children: [
                MoodPie(),
                MoodQuestionnaire(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
