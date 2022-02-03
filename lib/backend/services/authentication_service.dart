import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentalmath/backend/models/user.dart';

import '../../main.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<KUser?> get user {
    return _firebaseAuth.authStateChanges().map(
          (User? firebaseUser) => (firebaseUser != null)
              ? KUser(
                  uid: firebaseUser.uid,
                  email: firebaseUser.email,
                )
              : null,
        );
  }

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.offAll(AuthenticationWrapper());

      return "Signed In";
    } on FirebaseException catch (e) {
      Get.showSnackbar(GetBar(
        title: "Error Signing In!",
        message: "Invalid Username or Password",
        duration: const Duration(milliseconds: 1500),
      ));
      return 'Not Signed In';
    } catch (e) {
      Get.showSnackbar(GetBar(
        title: "Error Signing Up!",
        message: "Internal Server Error",
        duration: const Duration(milliseconds: 1500),
      ));
      return 'Not Signed Up';
    }
  }

  Future<String> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.offAll(AuthenticationWrapper());
      FirebaseFirestore.instance
          .collection("users")
          .doc(email)
          .set({"email": email});
      return "Signed Up";
    } on FirebaseException catch (e) {
      Get.showSnackbar(GetBar(
        title: "Error Signing Up!",
        message: (e.code == "email-already-in-use")
            ? "Email is already in use."
            : "Email is invalid",
        duration: const Duration(milliseconds: 1500),
      ));
      return 'Not Signed Up';
    } catch (e) {
      Get.showSnackbar(GetBar(
        title: "Error Signing Up!",
        message: "Internal Server Error",
        duration: const Duration(milliseconds: 1500),
      ));
      return 'Not Signed Up';
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      Get.offAll(AuthenticationWrapper());
    } on FirebaseException catch (e) {
      Get.showSnackbar(GetBar(
        title: "Error Signing Out!",
        message: "You weren't signed Out. Some Problem occurred.",
        duration: const Duration(milliseconds: 1500),
      ));
      // return 'Not Signed Up';
    } catch (e) {
      Get.snackbar("Error Signing Out", e.toString(),
          backgroundColor: Colors.white70);
    }
  }
}
