import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customFormField(
    {bool isPassword = false,
    required TextEditingController controller,
    required String hint,
    required String? Function(String?) validator}) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 5,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Vx.white,
    ),
    child: TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isPassword,
      cursorColor: const Color(0xff2E5C5C),
      style: const TextStyle(
          fontSize: 22, color: Color(0xff2E5C5C), fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
            color: Color(0xff2E5C5C), fontWeight: FontWeight.normal),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    ),
  );
}
