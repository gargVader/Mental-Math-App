import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentalmath/frontend/pages/core/home.dart';
import 'package:provider/provider.dart';
import 'backend/models/user.dart';
import 'backend/services/authentication_service.dart';
import 'frontend/pages/auth/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<KUser?>.value(
      initialData: null,
      value: Auth().user,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[100],
            appBarTheme: AppBarTheme(
              color: Colors.grey[100],
            )),
        home: Home(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final KUser? user = Provider.of<KUser?>(context);
    if (user != null) {
      return Home();
    } else if (user == null) {
      return SignInForm();
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
