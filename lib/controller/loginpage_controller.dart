import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:rescuerun/views/admin/adminhomepage.dart';
import 'package:rescuerun/views/ambulance/ambulance_homepage.dart';
import 'package:rescuerun/views/hospital/hospital_homepage.dart';
import 'package:rescuerun/views/users/user_homepage.dart';
import 'package:rescuerun/utils/apputils.dart';

class LoginPageController with ChangeNotifier {
  Future<void> onLogin({
    required String emailAddress,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // ✅ Step 1: Login with Firebase Auth
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        AppUtils.showSnackbar(context, message: "Login failed", bgColor: Colors.red);
        return;
      }

      // ✅ Step 2: Get the user's role from Firestore
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      if (!userDoc.exists || !userDoc.data()!.containsKey('role')) {
        AppUtils.showSnackbar(context, message: "No role found for this user", bgColor: Colors.red);
        return;
      }

      final role = userDoc['role'];

      // ✅ Step 3: Navigate to the correct screen
      AppUtils.showSnackbar(context, message: "Login Successful", bgColor: Colors.green);

      switch (role) {
        case 'user':
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UserHomePage()));
          break;
        case 'admin':
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AdminHomePage()));
          break;
        case 'ambulance':
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AmbulanceHomePage()));
          break;
        case 'hospital':
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HospitalHomePage()));
          break;
        default:
          AppUtils.showSnackbar(context, message: "Invalid role type", bgColor: Colors.red);
      }
    } on FirebaseAuthException catch (e) {
      AppUtils.showSnackbar(context, message: e.message ?? "Login failed", bgColor: Colors.red);
    } catch (e) {
      AppUtils.showSnackbar(context, message: "Unexpected error: $e", bgColor: Colors.red);
    }
  }
}




// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:rescue_run_app/utils/app_utils.dart';
// import 'package:rescue_run_app/view/users/user_homepage.dart';

// class LoginPageController with ChangeNotifier {
//   Future<void> onLogin({required String emailAddress,required String password,required BuildContext context}) async {
//     try {
//   final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//     email: emailAddress,
//     password: password
//   );
//   if(credential.user!=null){
   
//     AppUtils.showSnackbar(context, message: " Login Successfull",bgColor: Colors.green);
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserHomePage(),));
//   }
// } on FirebaseAuthException catch (e) {
//  AppUtils.showSnackbar(context, message: e.code, bgColor: Colors.green); 
// }
//   }
// }