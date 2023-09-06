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
            const Text(
              'As-tu une question ou une remarque ?',
              style: TextStyle(
                  color: Color.fromARGB(255, 237, 223, 252), fontSize: 24),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Je dois voir le praticien',
                style: TextStyle(
                  color: Color.fromARGB(255, 237, 223, 252),
                  fontSize: 24,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Je dois appeler le praticien',
                style: TextStyle(
                  color: Color.fromARGB(255, 237, 223, 252),
                  fontSize: 24,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
