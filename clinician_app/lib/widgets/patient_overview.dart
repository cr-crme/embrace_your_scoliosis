import 'package:auto_size_text/auto_size_text.dart';
import 'package:clinician_app/widgets/Calendar_date.dart';
import 'package:common_lib/models/database.dart';
import 'package:common_lib/models/enums.dart';
import 'package:common_lib/models/main_user.dart';
import 'package:common_lib/models/mood_list.dart';
import 'package:common_lib/models/patient_data.dart';
//import 'package:common_lib/models/wearing_time.dart';
import 'package:common_lib/models/wearing_time_list.dart';
import 'package:flutter/material.dart';

import 'package:common_lib/models/locale_text.dart';

import '/models/enums.dart';

class _BackgroundColors {
  final Color extraLight;
  final Color light;
  final Color dark;

  const _BackgroundColors(
      {required this.extraLight, required this.light, required this.dark});
// initialisation des couleurs de la fiche patient
  _BackgroundColors.red()
      : extraLight = const Color.fromARGB(255, 255, 187, 194),
        light = Colors.red[200]!,
        dark = Colors.red;

  _BackgroundColors.orange()
      : extraLight = Colors.orange[100]!,
        light = Colors.orange[200]!,
        dark = Colors.orange;

  _BackgroundColors.green()
      : extraLight = Colors.lightGreen[100]!,
        light = Colors.lightGreen[200]!,
        dark = Colors.green;

  factory _BackgroundColors.choseFromData(WearingTimeList? data) {
    //conditions des couleurs de la fiche en fonction du temps de port
    if (data == null ||
        data.meanWearingTimePerDay < ExpectedWearingTime.bad.id) {
      return _BackgroundColors.red();
    } else if (data.meanWearingTimePerDay < ExpectedWearingTime.good.id) {
      return _BackgroundColors.orange();
    } else {
      return _BackgroundColors.green();
    }
  }
}

class _Layout {
  final double height;
  final double width;
  final double cornerRadius;
  final double borderWidth;

  _Layout({
    required this.height,
    required this.width,
    required this.cornerRadius,
    required this.borderWidth,
  });
}

class PatientOverview extends StatefulWidget {
  PatientOverview(
    this.patient, {
    super.key,
    double height = 200.0,
    double width = 100.0,
  }) : _layout = _Layout(
            height: height, width: width, cornerRadius: 10, borderWidth: 4);

  final PatientData patient;
  final _Layout _layout;

  @override
  State<PatientOverview> createState() => _PatientOverviewState();
}

class _PatientOverviewState extends State<PatientOverview> {
  int _selected = 1;
  Future<MainUser?> _patient = Future<MainUser?>.value();

  @override
  void initState() {
    super.initState();
    _patient = _fetchUser();
  }

  Future<MainUser?> _fetchUser() async {
    return await Database.of(context)
        .user(widget.patient.id); //va chercher dans la database id patient
  }

  void select(int index) {
    _selected = index;
    setState(() {});
  }

  DateTime get _fromSelection {
    if (_selected == 0) {
      return dayChoose.subtract(const Duration(days: 1));
    } else if (_selected == 1) {
      return DateTime.now().subtract(const Duration(days: 7));
    } else if (_selected == 2) {
      return DateTime.now().subtract(const Duration(days: 30));
    } else {
      return DateTime.now().subtract(const Duration(days: 365));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MainUser?>(
        future: _patient,
        builder: (context, userSnapshot) {
          if (!userSnapshot.hasData) {
            return WaitingPatient(
                height: widget._layout.height, width: widget._layout.width);
          }
          final user = userSnapshot.data!;

          // Fetch the requested data by the user
          final wearingData =
              widget.patient.wearingData.getFrom(from: _fromSelection);
          final moodData =
              widget.patient.moodData.getFrom(from: _fromSelection);

          // Base the main color on the last 7 days
          final wearingListSevenDays = widget.patient.wearingData
              .getFrom(from: DateTime.now().subtract(const Duration(days: 7)));
          final moodListSevenDays = widget.patient.moodData
              .getFrom(from: DateTime.now().subtract(const Duration(days: 7)));
          final colors = _BackgroundColors.choseFromData(wearingListSevenDays);
          final colorMood = moodListSevenDays.mean.hasVeryBad
              ? _BackgroundColors.red()
              : colors;

          return Column(
            // définition des quatre parties de chaque fiche patient
            mainAxisSize: MainAxisSize.min,
            children: [
              _HeaderSection('${user.firstName} ${user.lastName}',
                  layout: widget._layout, colors: colors),
              _MeanTimeSection(wearingData,
                  layout: widget._layout, colors: colors),
              _MoodSection(moodData, layout: widget._layout, colors: colorMood),
              _DayButtonsSection(_selected,
                  layout: widget._layout, colors: colors, onPressed: select),
              Meeting(colors.light, colors.dark),
              // _Meeting(
              //   layout: widget._layout,
              //   colors: colors,
              // ),
            ],
          );
        });
  }
}

class WaitingPatient extends StatelessWidget {
  const WaitingPatient({Key? key, required this.height, required this.width})
      : super(key: key);

  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
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
          child: const Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection(
    this.name, {
    Key? key,
    required this.layout,
    required this.colors,
  }) : super(key: key);

  final String name;
  final _Layout layout;
  final _BackgroundColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: layout.height * 4 / 20,
      width: layout.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(layout.cornerRadius),
              topRight: Radius.circular(layout.cornerRadius)),
          border: Border.all(color: colors.dark, width: 4),
          color: colors.dark),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: AutoSizeText(
            name,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            minFontSize: Theme.of(context).textTheme.titleSmall!.fontSize!,
            maxFontSize: Theme.of(context).textTheme.titleLarge!.fontSize!,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}

class _MeanTimeSection extends StatelessWidget {
  const _MeanTimeSection(this.data,
      {required this.layout, required this.colors});

  final WearingTimeList? data;
  final _Layout layout;
  final _BackgroundColors colors;

  @override
  Widget build(BuildContext context) {
    final texts = LocaleText.of(context);

    return Container(
      height: layout.height * 2 / 20,
      width: layout.width,
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: colors.dark, width: layout.borderWidth)),
          color: colors.light),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: AutoSizeText(
                  data == null
                      ? texts.materialNowWore
                      : '${texts.wearingTime} ${data!.meanWearingTimePerDay.toStringAsFixed(1)}h',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DayTextButton extends StatelessWidget {
  const _DayTextButton(
    this.text, {
    Key? key,
    required this.layout,
    required this.colors,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final _Layout layout;
  final Color colors;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: colors,
            minimumSize: Size(layout.width / 4, layout.height * 1 / 6 / 1.3),
            side:
                BorderSide(color: Colors.black, width: layout.borderWidth / 4),
          ),
          onPressed: onPressed,
          child:
              AutoSizeText(text, style: const TextStyle(color: Colors.black)),
        ));
  }
}

class _MoodSection extends StatelessWidget {
  //classe des différents moods
  const _MoodSection(
    this.moodData, {
    required this.layout,
    required this.colors,
  });

  final MoodList? moodData;
  final _Layout layout;
  final _BackgroundColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors.light,
        border: Border(
            bottom: BorderSide(color: colors.dark, width: layout.borderWidth)),
      ),
      height: layout.height * 8.5 / 20,
      width: layout.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _meanMoodShow(context, layout, 'Émotion', moodData?.mean.emotion),
              _meanMoodShow(context, layout, 'Confort', moodData?.mean.comfort),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _meanMoodShow(
                  context, layout, 'Humidité', moodData?.mean.humidity),
              _meanMoodShow(
                  context, layout, 'Autonomy', moodData?.mean.autonomy),
            ],
          ),
        ],
      ),
    );
  }

  Widget _meanMoodShow(BuildContext context, _Layout layout, String category,
      MoodDataLevel? mood) {
    return Column(
      children: [
        AutoSizeText(category, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 3),
        if (mood != null && mood != MoodDataLevel.none)
          Image.asset(
            mood.path,
            width: layout.width / 5,
            cacheWidth: layout.width ~/ 5,
            package: 'common_lib',
          ),
      ],
    );
  }
}

DateTime dayChoose = DateTime.now();

class _DayButtonsSection extends StatelessWidget {
  // classe boutton pour choisir les jours
  const _DayButtonsSection(
    this.selected, {
    required this.layout,
    required this.colors,
    required this.onPressed,
  });

  final _Layout layout;
  final _BackgroundColors colors;
  final int selected;
  final Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    void openDateOverlay() {
      //méthode permettant d'ouvrir la page ou le patient pose sa question
      showModalBottomSheet(
        context: context,
        builder: (ctx) =>
            CalendarDate(onChooseDate: (selectedDate) => onPressed(0)),
      );
    }

    //partie bouttons des jours
    return Container(
      width: layout.width,
      height: layout.height * 3.5 / 20,
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: colors.dark, width: layout.borderWidth)),
        color: colors.light,
        //borderRadius: BorderRadius.only(
        //bottomLeft: Radius.circular(layout.cornerRadius),
        //bottomRight: Radius.circular(layout.cornerRadius),
        //)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton.icon(
            onPressed: openDateOverlay,
            icon: Icon(
              Icons.calendar_month,
              color: selected == 0 ? colors.dark : colors.extraLight,
            ),
            label: const Text(
              '1j',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          // Expanded(
          //   child: _DayTextButton('1j',
          //       layout: layout,
          //       colors: selected == 0 ? colors.dark : colors.extraLight,
          //       onPressed: () => onPressed(0)),
          // ),
          Expanded(
            child: _DayTextButton('7j',
                layout: layout,
                colors: selected == 1 ? colors.dark : colors.extraLight,
                onPressed: () => onPressed(1)),
          ),
          Expanded(
            child: _DayTextButton('30j',
                layout: layout,
                colors: selected == 2 ? colors.dark : colors.extraLight,
                onPressed: () => onPressed(2)),
          ),
          Expanded(
            child: _DayTextButton('1a',
                layout: layout,
                colors: selected == 3 ? colors.dark : colors.extraLight,
                onPressed: () => onPressed(3)),
          ),
        ],
      ),
    );
  }
}

class Meeting extends StatefulWidget {
  const Meeting(this.light, this.dark, {super.key});

  final Color light;
  final Color dark;

  @override
  State<Meeting> createState() {
    return _MeetingState();
  }
}

class _MeetingState extends State<Meeting> {
  Color activeColor = Colors.black;

  void switchColor() {
    setState(() {
      activeColor = Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 112, 82, 163),
              Color.fromARGB(255, 127, 78, 159),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )),
      width: 200,
      height: 200 * 3 / 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.add_call,
              color: activeColor == Colors.black
                  ? const Color.fromARGB(255, 0, 0, 0)
                  : const Color.fromARGB(255, 255, 255, 255),
            ),
            label: Text(
              'Appel',
              style: TextStyle(
                color: activeColor == Colors.black
                    ? const Color.fromARGB(255, 0, 0, 0)
                    : const Color.fromARGB(255, 255, 255, 255),
                fontSize: 10,
              ),
            ),
          ),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.accessibility_new,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            label: const Text(
              'RDV',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class _Meeting extends StatelessWidget {
//   const _Meeting({required this.layout, required this.colors});

//   final _Layout layout;
//   final _BackgroundColors colors;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           color: colors.light,
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(layout.cornerRadius),
//             bottomRight: Radius.circular(layout.cornerRadius),
//           )),
//       width: layout.width,
//       height: layout.height * 2 / 20,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           OutlinedButton.icon(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.add_call,
//               color: Color.fromARGB(255, 0, 0, 0),
//             ),
//             label: const Text(
//               'Appel',
//               style: TextStyle(
//                 color: Color.fromARGB(255, 0, 0, 0),
//                 fontSize: 10,
//               ),
//             ),
//           ),
//           OutlinedButton.icon(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.accessibility_new,
//               color: Color.fromARGB(255, 0, 0, 0),
//             ),
//             label: const Text(
//               'RDV',
//               style: TextStyle(
//                 color: Color.fromARGB(255, 0, 0, 0),
//                 fontSize: 10,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
