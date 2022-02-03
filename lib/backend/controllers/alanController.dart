import 'dart:convert';
import 'package:alan_voice/alan_voice.dart';
import 'package:get/get.dart';
import 'package:mentalmath/backend/controllers/quizController.dart';
import 'package:mentalmath/frontend/pages/core/quiz.dart';

class AlanController extends GetxController {
  void handleCommand(Map<String, dynamic> command) {
    print("Command =  $command");
    if (command["commmand"] == "navigate") {
      print('Navigation UJ triggered');
      _handleNavigation(command["route"]);
    } else if (command["command"] == "resultSpoken") {
      _handleAnswer(command["result"]);
    }
  }

  void sendData(String question, String result) {
    question = "What is $question ?";
    var params = jsonEncode({"question": question, "result": result});
    AlanVoice.callProjectApi("script::playQuestion", params);
  }

  _handleNavigation(String route) {
    if (route == 'back') {
      Get.back();
    } else {
      Get.to(ProblemPage(track: route));
    }
  }

  _handleAnswer(String ans) {
    var _quizController = Get.put(QuizController());
    var _question = _quizController.getCurrentQuestion();
    print("ans = " + ans);
    print(_question["question"].toString());
    print(_question["result"].toString());
    if (_question["result"].toString() == ans) {
      playText("Correct answer");
    } else {
      playText("Wrong Answer. It is ${_question["result"]}");
    }
  }

  void playText(String text) {
    var params = jsonEncode({"text": text});
    AlanVoice.callProjectApi("script::playText", params);
  }
}
