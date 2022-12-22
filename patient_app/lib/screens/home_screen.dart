import 'package:flutter/material.dart';

import '../widgets/mood_pie.dart';
import '../widgets/mood_questionnaire.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              children: const [
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
