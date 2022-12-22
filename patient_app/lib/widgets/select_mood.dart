import 'package:common_lib/models/enums.dart';
import 'package:common_lib/models/locale_text.dart';
import 'package:common_lib/models/mood.dart';
import 'package:flutter/material.dart';

class SelectMood extends StatefulWidget {
  const SelectMood({super.key});

  @override
  State<SelectMood> createState() => _SelectMoodState();
}

class _SelectMoodState extends State<SelectMood> {
  Mood mood = Mood(DateTime.now());

  void _setEmotion(MoodDataLevel level) {
    mood = mood.copyWith(emotion: level);
    setState(() {});
  }

  void _setComfort(MoodDataLevel level) {
    mood = mood.copyWith(comfort: level);
    setState(() {});
  }

  void _setHumidity(MoodDataLevel level) {
    mood = mood.copyWith(humidity: level);
    setState(() {});
  }

  void _setAutonomy(MoodDataLevel level) {
    mood = mood.copyWith(autonomy: level);
    setState(() {});
  }

  void _submit() {
    Navigator.of(context).pop(mood);
  }

  @override
  Widget build(BuildContext context) {
    final sideSize = MediaQuery.of(context).size.width / 12;
    final texts = LocaleText.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(texts.feelingToday),
        const SizedBox(height: 20),
        SelectMoodLevel(
          title: texts.emotion,
          sideSize: sideSize,
          onTap: _setEmotion,
          current: mood.emotion,
        ),
        const SizedBox(height: 12),
        SelectMoodLevel(
          title: texts.comfort,
          sideSize: sideSize,
          onTap: _setComfort,
          current: mood.comfort,
        ),
        const SizedBox(height: 12),
        SelectMoodLevel(
          title: texts.humidity,
          sideSize: sideSize,
          onTap: _setHumidity,
          current: mood.humidity,
        ),
        const SizedBox(height: 12),
        SelectMoodLevel(
          title: texts.autonony,
          sideSize: sideSize,
          onTap: _setAutonomy,
          current: mood.autonomy,
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: mood.isSet ? _submit : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Theme.of(context).colorScheme.onSecondary,
            elevation: 2,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(texts.submit),
          ),
        ),
      ],
    );
  }
}

class SelectMoodLevel extends StatefulWidget {
  const SelectMoodLevel({
    super.key,
    required this.title,
    required this.sideSize,
    required this.onTap,
    required this.current,
  });

  final String title;
  final double sideSize;
  final Function onTap;
  final MoodDataLevel current;

  @override
  State<SelectMoodLevel> createState() => _SelectMoodLevelState();
}

class _SelectMoodLevelState extends State<SelectMoodLevel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _emoticoneBuilder(MoodDataLevel.veryBad),
            _emoticoneBuilder(MoodDataLevel.poor),
            _emoticoneBuilder(MoodDataLevel.medium),
            _emoticoneBuilder(MoodDataLevel.good),
            _emoticoneBuilder(MoodDataLevel.excellent),
          ],
        ),
      ],
    );
  }

  _Selector _emoticoneBuilder(MoodDataLevel mood) {
    return _Selector(
      AssetImage(mood.path, package: 'common_lib'),
      onTap: () => widget.onTap(mood),
      isSelected: widget.current == mood,
      sideSize: widget.sideSize,
    );
  }
}

class _Selector extends StatelessWidget {
  const _Selector(
    this.image, {
    Key? key,
    required this.onTap,
    required this.sideSize,
    required this.isSelected,
  }) : super(key: key);

  final AssetImage image;
  final Function() onTap;
  final double sideSize;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: image,
            colorFilter: ColorFilter.mode(
              Colors.white.withAlpha(isSelected ? 255 : 70),
              BlendMode.modulate,
            ),
          ),
        ),
        height: sideSize,
        width: sideSize,
      ),
    );
  }
}
