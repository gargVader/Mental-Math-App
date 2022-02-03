import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'confirmEmail.dart';

class ForgotPassword extends StatelessWidget {
  final String message =
      "An email has just been sent to you, Click the link provided to complete password reset";

  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  String? _email;

  Future<void> _passwordReset() async {
    try {
      _formKey.currentState!.save();
      final user = await _auth.sendPasswordResetEmail(email: _email.toString());

      Get.off(() => ConfirmEmail(
            message: message,
          ));
    } catch (e) {
      Get.showSnackbar(GetBar(
        title: "Error",
        message: "Couldn't find an account associated with this email.",
        duration: const Duration(milliseconds: 1700),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.gray900,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              "Enter Your Email"
                  .text
                  .color(const Color(0xff4DBABD))
                  .textStyle(GoogleFonts.poppins())
                  .semiBold
                  .xl3
                  .make(),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  if (!value!.isEmail) {
                    return "Enter a valid email";
                  }
                  return null;
                },
                onSaved: (newEmail) {
                  _email = newEmail;
                },
                cursorColor: const Color(0xff499295),
                style: const TextStyle(color: Color(0xff499295)),
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff499295))),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff499295))),
                  labelText: 'Email',
                  icon: Icon(
                    Icons.mail,
                    color: Color(0xff499295),
                  ),
                  errorStyle: TextStyle(color: Colors.red),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _passwordReset();
                    // print(_email);
                  }
                },
                child: "Send Reset Link".text.gray800.xl.bold.make(),
              ).box.color(const Color(0xff4DBABD)).roundedSM.p12.make(),
            ],
          ),
        ),
      ),
    );
  }
}
