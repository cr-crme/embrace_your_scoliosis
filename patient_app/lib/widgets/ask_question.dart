import 'package:flutter/material.dart';

class AskQuestions extends StatelessWidget {
  const AskQuestions({super.key});
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
              onPressed: () {},
              icon: const Icon(Icons.arrow_right_alt),
              label: const Text(
                'As-tu une question ou une remarque ?',
                style: TextStyle(
                    color: Color.fromARGB(255, 237, 223, 252), fontSize: 15),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_call),
              label: const Text(
                'Je veux avoir un appel avec mon médecin',
                style: TextStyle(
                  color: Color.fromARGB(255, 237, 223, 252),
                  fontSize: 15,
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.accessibility_new),
              label: const Text(
                'Je veux avoir un rendez-vous avec mon médecin',
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
