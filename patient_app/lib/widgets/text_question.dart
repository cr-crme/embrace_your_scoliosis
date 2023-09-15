import 'package:flutter/material.dart';

class TextQuestions extends StatefulWidget {
  const TextQuestions({super.key});

  @override
  State<TextQuestions> createState() {
    return _TextQuestions();
  }
}

class _TextQuestions extends State<TextQuestions> {
  final _questionControler =
      TextEditingController(); // permet de save ce que le patient à écrit

  @override
  void dispose() {
    // permet de delete le controller quand on ne s'en sert pas (permet de ne pas enregistrer pour rien)
    _questionControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _questionControler,
            maxLength: 100,
            decoration: const InputDecoration(
              label: Text('Ask us your question'),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(
                      context); //enlève la page de question de l'écran
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  print(_questionControler.text);
                },
                child: const Text('submit'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
