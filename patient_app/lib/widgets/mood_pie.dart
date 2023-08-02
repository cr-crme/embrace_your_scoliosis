import 'dart:math';

import 'package:common_lib/models/locale_text.dart';
import 'package:common_lib/models/patient_data_list.dart';
import 'package:flutter/material.dart';

import 'pie.dart';

class MoodPie extends StatelessWidget {
  const MoodPie({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = LocaleText.of(context);
    final data = PatientDataList.of(context).myData(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.purple),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 8),
          Transform.rotate(
            angle: -pi / 20,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  texts.meanWearingTime,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 12),
          Pie(
            radius: MediaQuery.of(context).size.height / 6,
            sweepAngle: pi,
            colors: const [
              Colors.red,
              Colors.orange,
              Colors.yellow,
              Colors.green,
            ],
            targetAngle: data.wearingData.meanWearingTimePerDay / 24,
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${data.wearingData.meanWearingTimePerDay.toStringAsFixed(1)}h/${texts.day}',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 12),
        ],
      ),
    );
  }
}
