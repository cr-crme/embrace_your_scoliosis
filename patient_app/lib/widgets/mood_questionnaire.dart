import 'dart:math';

import 'package:common_lib/models/locale_text.dart';
import 'package:common_lib/models/mood.dart';
import 'package:common_lib/models/patient_data_list.dart';
import 'package:flutter/material.dart';

import '/widgets/select_mood.dart';

class MoodQuestionnaire extends StatelessWidget {
  const MoodQuestionnaire({super.key});

  void _selectMood(context) async {
    final mood = await showDialog<Mood>(
        context: context,
        builder: ((context) => const AlertDialog(content: SelectMood())));
    if (mood == null) return;
    PatientDataList.of(context).addMood(context, mood);
  }

  @override
  Widget build(BuildContext context) {
    final texts = LocaleText.of(context);
    return Flexible(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Colors.orange),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: pi / 25,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    texts.tellUsNowYouFeel,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => _selectMood(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary),
                child: Text(texts.selectMood)),
          ],
        ),
      ),
    );
  }
}
