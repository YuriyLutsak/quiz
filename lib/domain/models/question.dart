class Question {
  final String question;
  final List<String> answers;

  Question(this.question, this.answers);

  List<String> getShuffledAnswers() {
    return List.of(answers)..shuffle();
  }
}
