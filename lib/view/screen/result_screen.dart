import 'package:flutter/material.dart';

import '../../components/questions_summery.dart';
import '../../data/questions.dart';

class ResultScreen extends StatelessWidget {
  final List<String> chosenAnswers;
  final void Function() onRestart;

  const ResultScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
  });

  List<Map<String, Object>> getSummaryData() {
    return List.generate(chosenAnswers.length, (i) {
      // generate - генерирую, итерируясь (chosenAnswers.length) по длине chosenAnswers
      // придумываю ключь для каждого поля в моделе/json questions
      return {
        'questions_index': i,
        'question': questions[i].question,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = getSummaryData().where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: QuestionsSummary(getSummaryData()),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white),
              ),
              icon: const Icon(Icons.restart_alt),
              onPressed: onRestart,
              label: const Text('Restart Quiz!'),
            ),
          ],
        ),
      ),
    );
  }
}
