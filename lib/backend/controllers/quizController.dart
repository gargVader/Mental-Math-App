import 'dart:math';

import 'package:get/get.dart';
import 'package:mentalmath/backend/controllers/alanController.dart';

class QuizController extends GetxController {
  Map<String, dynamic> _question = {};
  int random(min, max) {
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }

  Map<String, dynamic> additonQuiz() {
    int a = random(10, 99);
    int b = random(10, 99);
    int result = a + b;
    return {'question': '$a + $b', 'result': result};
  }

  Map<String, dynamic> multiplicationQuiz() {
    int a = random(1, 10);
    int b = random(1, 10);
    int result = a * b;
    return {'question': '$a * $b', 'result': result};
  }

  Map<String, dynamic> squaresQuiz() {
    int a = random(1, 25);
    int result = a * a;
    return {'question': '$a^2', 'result': result};
  }

  Map<String, dynamic> handlerFunction(String track) {
    switch (track) {
      case 'add':
        _question = additonQuiz();
        break;
      case 'multiply':
        _question = multiplicationQuiz();
        break;
      case 'square':
        _question = squaresQuiz();
        break;
    }

    return _question;
  }

  Map<String, dynamic> getCurrentQuestion() {
    return _question;
  }
}
