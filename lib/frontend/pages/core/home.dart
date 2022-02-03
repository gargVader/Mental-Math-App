import 'dart:convert';
import 'package:alan_voice/alan_voice.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentalmath/backend/constants/testTrackData.dart';
import 'package:mentalmath/backend/controllers/alanController.dart';
import 'package:mentalmath/backend/controllers/quizController.dart';
import 'package:mentalmath/frontend/pages/core/quiz.dart';
import 'package:mentalmath/frontend/widgets/misc/gridButtons.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final alanController = Get.put(AlanController());
  _HomeState() {
    AlanVoice.addButton(
        "36cf10a045ad4f147daed15d057fa38b2e956eca572e1d8b807a3e2338fdd0dc/prod");
    AlanVoice.onCommand.add((command) {
      alanController.handleCommand(command.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: HStack([
            "Mental".text.black.xl3.make(),
            "Math".text.yellow500.make(),
          ]),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Swiper(
              itemHeight: Get.height * .4,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  key: Key(testTracks[index]['id'].toString()),
                  onTap: () {
                    Get.to(ProblemPage(
                        track: testTracks[index]['track'].toString()));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                                testTracks[index]['image'].toString()),
                            fit: BoxFit.fill,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              testTracks[index]['title'].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      )),
                );
              },
              itemCount: testTracks.length,
              itemWidth: 300,
              layout: SwiperLayout.STACK,
            ),
            GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              childAspectRatio: (Get.width / 2) / (Get.height / 4.5),
              crossAxisSpacing: 10,
              children: [
                gridWidget('assets/stat.png', Colors.grey[200]),
                gridWidget('assets/bar.png', Colors.yellow),
                gridWidget('assets/stat.png', Colors.yellow),
                gridWidget('assets/stat.png', Colors.grey[200]),
              ],
            ),
          ],
        ));
  }
}
