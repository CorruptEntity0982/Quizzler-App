import 'question.dart';

class QuizBrain {
  final List<Question> _questionBank = [
    Question(
        q: 'You can lead a cow up the stairs but not down the stairs',
        a: false),
    Question(
        q: 'Approximately one quater of human bones are in the feet', a: true),
    Question(q: 'A slug\'s blood is green', a: true),
  ];
  String getQuestion() {
    return _questionBank[_qnumber].question;
  }

  bool getAnswer() {
    return _questionBank[_qnumber].answer;
  }

  int _qnumber = 0;
  int _score = 0;
  void increaseScore() {
    _score++;
  }

  int showScore() {
    return _score;
  }

  void nextQuestion() {
    if (_qnumber <= _questionBank.length) {
      _qnumber++;
    }
  }

  bool checkEnd() {
    if (_qnumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _qnumber = 0;
    _score = 0;
  }
}
