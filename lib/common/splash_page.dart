import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rescuerun/components/apptext.dart';
import 'package:rescuerun/constant/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/admin/adminhomepage.dart';
import '../views/ambulance/ambulance_homepage.dart';
import '../views/hospital/hospital_homepage.dart';
import '../views/users/user_homepage.dart';
import '../services/userservice.dart';
import 'Login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  UserService _userService = UserService();
  String? _type;
  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _type = await _pref.getString('type');
    setState(() {});
  }

  Future<void> _checkLoginStatus() async {
    bool isLoggedIn = await _userService.isLoggedin();
    print(isLoggedIn);
    if (!isLoggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      if (_type == "user") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => UserHomePage()),
                (route) => false);
      }

      else if (_type == "admin") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AdminHomePage()),
                (route) => false);
      }

      else if (_type == "hospital") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HospitalHomePage()),
                (route) => false);
      }
      else if(_type=="ambulance"){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AmbulanceHomePage()),
                (route) => false);
      }
    }
  }
  @override
  void initState() {
    getData();
    var d = Duration(seconds: 2);

    Future.delayed(d, () {
      _checkLoginStatus();
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // new Future.delayed(const Duration(seconds: 1), () {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => LoginPage()));
    // });
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/images/bg1.jpg'))),
        padding: EdgeInsets.all(100),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "RescueRun",
                style: TextStyle(
                  color: Colors.teal.shade900,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  overflow: TextOverflow.visible,
                ),

              ),
              SizedBox(height: 50,),
              CircleAvatar(
                  // backgroundColor: Colors.tealAccent,
                  backgroundColor: Colors.teal.shade100,
                  radius: 70,
                  child: Image.asset(
                    'assets/images/logo2.png',
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: 100,
              ),
              AppText(
                data:"Go Fast",
                color: Colors.teal.shade900,
                size: 18,
                fw: FontWeight.w800,
                overflow: TextOverflow.visible,
              ),
              AppText(
                data: "&",
                color: Colors.teal.shade900,
                size: 18,
                fw: FontWeight.w800,
                overflow: TextOverflow.visible,
              ),
              AppText(
                data: "Track Your Rescue",
                color: Colors.teal.shade900,
                size: 18,
                fw: FontWeight.w800,
              ),
              SizedBox(height: 50,),
              AppText(
                data: "Save a Life",
                color: Colors.teal.shade900,
                size: 30,
                fw: FontWeight.w800,
                overflow: TextOverflow.visible,
              ),
              // InkWell(
              //   onTap: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
              //   },
              //   child: ListTile(
              //         trailing: Container(
              //           height: 40,
              //           width: 40,
              //           decoration:
              //           BoxDecoration(shape: BoxShape.circle, color: Colors.teal),
              //           child: Center(
              //             child: Icon(Icons.arrow_forward_ios),
              //           ),
              //         ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
