import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:rescuerun/common/Login_page.dart';
import 'package:rescuerun/utils/apputils.dart';

class RegistrationPageController with ChangeNotifier {
  Future<void> onRegister({
    required String emailAddress,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      if (credential.user != null) {
        AppUtils.showSnackbar(context,
            message: "User registration Successfull");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
      }
    } on FirebaseAuthException catch (e) {
      //show error message besed on firebase exception
      if (e.code == 'weak-password') {
        AppUtils.showSnackbar(context,
            message: "The password provided is too weak");
      } else if (e.code == 'email-already-in-use') {
        AppUtils.showSnackbar(context,
            message: "The account already exists for that email");
      }
    } catch (e) {
      // print any other exception
      AppUtils.showSnackbar(context, message: e.toString());
    }
  }
}
