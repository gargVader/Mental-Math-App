import 'package:flutter/material.dart';

Widget gridWidget(String image, color) {
  return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.contain,
          )),
      child: Text(""));
}
