import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentalmath/backend/services/validation_service.dart';
import 'package:mentalmath/frontend/widgets/auth_widgets/authForms.dart';
import 'package:velocity_x/velocity_x.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> with Validators {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  bool isSignUp = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.gray900,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 15,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  // Image.asset(
                  //   "images/fg.png",
                  //   width: Get.width * .7,
                  // ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "MENTAL",
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          color: Vx.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "MATH",
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          color: const Color(0xff4DBABD),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (isSignUp)
                    signUpForm(
                        confirmPassValidator,
                        _formkey,
                        emailController,
                        confirmPasswordController,
                        passwordController,
                        emailValidator,
                        passwordValidator)
                  else
                    signInForm(_formkey, emailController, passwordController,
                        emailValidator, passwordValidator),
                  registerUnderline(),
                ],
              )),
        ),
      ),
    );
  }

  String? confirmPassValidator(String? value) {
    if (value != passwordController.text) {
      return "Passwords don't match";
    }
    return null;
  }

  Widget registerUnderline() {
    return HStack([
      if (!isSignUp)
        "No Account? ".text.lg.color(const Color(0xff4DBABD)).make()
      else
        "Have an Account? ".text.lg.color(const Color(0xff4DBABD)).make(),
      GestureDetector(
        onTap: () {
          setState(() {
            isSignUp = !isSignUp;
            emailController.clear();
            passwordController.clear();
            confirmPasswordController.clear();
          });
        },
        child: isSignUp
            ? "Login Here     "
                .text
                .color(const Color(0xff4DBABD))
                .bold
                .lg
                .make()
            : "Register Here     "
                .text
                .color(const Color(0xff4DBABD))
                .bold
                .lg
                .make(),
      )
    ]).centered();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
