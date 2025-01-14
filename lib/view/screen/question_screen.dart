import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/components/answer_button.dart';
import 'package:quiz/data/questions.dart';

class QuestionScreen extends StatefulWidget {
  final void Function(String answer) onSelectAnswer;

  const QuestionScreen({super.key, required this.onSelectAnswer});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);

    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final questionTextStyle = TextStyle(
      fontSize: screenWidth * 0.05,
    );
    final buttonPadding = EdgeInsets.symmetric(
      vertical: screenHeight * 0.01,
    );

    return Center(
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: SingleChildScrollView(
            child: Column(
              key: ValueKey(currentQuestionIndex),
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  currentQuestion.question,
                  style: questionTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                ...currentQuestion.getShuffledAnswers().map((answer) {
                  return Padding(
                    padding: buttonPadding,
                    child: AnswerButton(
                      text: answer,
                      onTap: () {
                        answerQuestion(answer);
                      },
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
