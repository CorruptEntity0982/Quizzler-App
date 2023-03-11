import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'QuizBrain.dart';

void main() {
  runApp(
    const QuizApp(),
  );
}

QuizBrain quizBrain = QuizBrain();

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
} //stateless includes scaffold Dont touch

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int n = 0;
  List<Icon> scoreKeeper = [
    const Icon(Icons.add),
  ];
  void checkAnswer(bool answerr) {
    setState(() {
      int n = quizBrain.showScore();
      if (quizBrain.checkEnd()) {
        Alert(
            context: context,
            type: AlertType.info,
            title: 'End of Quiz',
            desc: 'Quiz will be restarted\n Your score is $n',
            buttons: [
              DialogButton(
                  child: const Text(
                    'Okay',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {}),
            ]).show();
        debugPrint('Alert closed now');
        quizBrain.reset();
        scoreKeeper = [];
      } else {
        if (answerr == quizBrain.getAnswer()) {
          quizBrain.increaseScore();
          scoreKeeper.add(
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scoreKeeper.add(
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestion(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ), //Text part
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                quizBrain.getAnswer();
                checkAnswer(true);
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green),
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ), //True button
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                quizBrain.getAnswer();
                checkAnswer(false);
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red),
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ), //False button
        Row(
          children: scoreKeeper,
        ), // Tick or cross row
      ],
    );
  }
}
