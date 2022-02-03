import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:mentalmath/backend/constants/constants.dart';
import 'package:mentalmath/backend/controllers/alanController.dart';
import 'package:mentalmath/backend/controllers/quizController.dart';
import 'package:velocity_x/velocity_x.dart';

class ProblemPage extends StatefulWidget {
  final String track;
  ProblemPage({Key? key, required this.track}) : super(key: key);

  @override
  State<ProblemPage> createState() => _ProblemPageState();
}

class _ProblemPageState extends State<ProblemPage> {
  QuizController _quizController = Get.put(QuizController());

  final formKey = new GlobalKey<FormState>();

  String buttonText(int value) {
    switch (value) {
      case 0:
        return "Check Answer";
      case 1:
        return "Correct Answer";
      case -1:
        return "Wrong Answer";
    }
    return "Check Answer";
  }

  final _countdownController = CountDownController();

  final alanController = Get.put(AlanController());

  var _question;
  @override
  void initState() {
    _question = _quizController.handlerFunction(widget.track);
    alanController.sendData(
        _question['question'], _question['result'].toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularCountDownTimer(
                  duration: Constants().timerDuration,
                  initialDuration: 0,
                  controller: _countdownController,
                  width: MediaQuery.of(context).size.width / 2.2,
                  height: MediaQuery.of(context).size.height / 2.8,
                  ringColor: Vx.gray100,
                  ringGradient: null,
                  fillColor: Vx.blue300,
                  fillGradient: null,
                  backgroundColor: Vx.blue500,
                  backgroundGradient: null,
                  strokeWidth: 20.0,
                  strokeCap: StrokeCap.round,
                  textStyle: TextStyle(
                      fontSize: 33.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textFormat: CountdownTextFormat.S,
                  isReverse: true,
                  isReverseAnimation: true,
                  isTimerTextShown: true,
                  autoStart: true,
                  onStart: () {
                    print('Countdown Started');
                  },
                  onComplete: () {
                    print('Countdown Ended');
                    setState(() {
                      _question = _quizController.handlerFunction(widget.track);
                    });
                    alanController.sendData(
                        _question['question'], _question['result'].toString());
                    _countdownController.restart(
                        duration: Constants().timerDuration);
                  },
                ),
                Text(
                  _question['question'],
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
