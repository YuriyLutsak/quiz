import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  final void Function() startQuiz;

  const StartScreen({super.key, required this.startQuiz});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/logo.png'),
            OutlinedButton.icon(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: startQuiz,
              label: const Text('Start Quiz'),
            )
          ],
        ),
      ),
    );
  }
}
