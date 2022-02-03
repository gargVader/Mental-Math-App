import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../main.dart';

class ConfirmEmail extends StatelessWidget {
  final String message;

  const ConfirmEmail({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            message.text.xl.make(),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () => Get.offAll(() => AuthenticationWrapper()),
              child: "Back to Login".text.xl.white.make(),
            ).box.rounded.red500.p12.make()
          ],
        ),
      ),
    );
  }
}
