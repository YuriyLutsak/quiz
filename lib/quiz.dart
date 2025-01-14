import 'package:flutter/material.dart';
import 'package:quiz/data/questions.dart';
import 'package:quiz/view/screen/question_screen.dart';
import 'package:quiz/view/screen/result_screen.dart';
import 'package:quiz/view/screen/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';

  void switchScreens() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'question-screen';
    });
  }

  Widget getScreen(String screenName) {
    switch (screenName) {
      case 'question-screen':
        return QuestionScreen(onSelectAnswer: chooseAnswer);
      case 'result-screen':
        return ResultScreen(
          chosenAnswers: selectedAnswers,
          onRestart: restartQuiz,
        );
      default:
        return StartScreen(startQuiz: switchScreens);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: Container(
            key: ValueKey(activeScreen),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.lightBlueAccent,
                  Colors.greenAccent,
                ],
              ),
            ),
            child: getScreen(activeScreen),
          ),
        ),
      ),
    );
  }
}
