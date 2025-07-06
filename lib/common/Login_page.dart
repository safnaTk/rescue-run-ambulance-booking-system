import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:rescuerun/views/users/user_homepage.dart';
import 'package:rescuerun/views/users/user_registration.dart';
import 'package:rescuerun/components/appbutton.dart';
import 'package:rescuerun/components/apptext.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/colors.dart';
import '../models/usermodel.dart';
import '../views/admin/adminhomepage.dart';
import '../views/ambulance/ambulance_homepage.dart';
import '../views/ambulance/ambulance_registration.dart';
import '../views/hospital/hospital_homepage.dart';
import '../services/userservice.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  final _loginKey = GlobalKey<FormState>();

  bool _forgot = false;

  bool _showPass = true;
  UserService _userService = UserService();
  UserModel _user = UserModel();
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    _user = UserModel(
        email: _emailController.text.trim(),
        password: _passController.text.trim());

    try {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(Duration(seconds: 2));
      DocumentSnapshot data = await _userService.loginUser(_user);

      print(data['userType']);
      var _type = data['userType'];

      if (_type == "admin") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AdminHomePage()),
            (route) => false);
      }

      if (_type == "hospital") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HospitalHomePage()),
            (route) => false);
      }

      if (_type == "ambulance") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AmbulanceHomePage()),
            (route) => false);
      }

      if (_type == "user") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => UserHomePage()),
            (route) => false);
      }

      // Navigate to the next page after registration is complete
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });

      List err = e.toString().split("]");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
          content: Container(
              height: 85,
              child: Center(
                  child: Row(
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Icon(
                        Icons.warning,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(child: Text(err[1].toString())),
                ],
              )))));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }

    // Simulate registration delay
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 5,
          // leading: BackButton(
          //   onPressed: () {
          //     FirebaseAuth.instance.signOut().then((value) {
          //       Navigator.pushAndRemoveUntil(
          //           context,
          //           MaterialPageRoute(builder: (context) => SplashPage()),
          //           (route) => false);
          //     });
          //   },
          // ),
        ),
        backgroundColor: Colors.tealAccent,
        body: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                  child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/bg3.jpg'),
                  ),
                ),
                child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(35),
                              height: 700,
                              decoration: BoxDecoration(
                                color: Colors.teal.shade100.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Form(
                                key: _loginKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          AppText(
                                            data: "RescueRun",
                                            color: Colors.teal.shade900,
                                            fw: FontWeight.w800,
                                            size: 30,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    Colors.teal.shade200,
                                                radius: 50,
                                                child: Image.asset(
                                                  'assets/images/logo2.png',
                                                  width: 90,
                                                  height: 90,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          AppText(
                                            data: "LOGIN",
                                            color: Colors.blue,
                                            fw: FontWeight.w800,
                                            size: 25,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Email is required";
                                              }
                                            },
                                            style:
                                                TextStyle(color: Colors.black),
                                            controller: _emailController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets
                                                    .symmetric(
                                                  horizontal: 10,
                                                ),
                                                hintText: "Email",
                                                hintStyle: TextStyle(
                                                    color: Colors
                                                        .teal.shade300),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Colors.blueGrey,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.cyan
                                                                    .shade500,
                                                            width: 1.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10))),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "password is required";
                                              }
                                            },
                                            style:
                                                TextStyle(color: Colors.black),
                                            controller: _passController,
                                            keyboardType: TextInputType.text,
                                            obscureText: _showPass,
                                            decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    if (_showPass == true) {
                                                      setState(() {
                                                        _showPass = false;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        _showPass = true;
                                                      });
                                                    }
                                                  },
                                                  icon: _showPass == false
                                                      ? Icon(
                                                          Icons.visibility,
                                                          color: Colors
                                                              .teal.shade300,
                                                        )
                                                      : Icon(
                                                          Icons.visibility_off,
                                                          color: Colors
                                                              .teal.shade300,
                                                        ),
                                                ),
                                                contentPadding: EdgeInsets
                                                    .symmetric(horizontal: 10),
                                                hintText: "Password",
                                                hintStyle: TextStyle(
                                                    color: Colors
                                                        .teal.shade300),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Colors.blueGrey,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide(
                                                                color: Colors
                                                                    .cyan
                                                                    .shade500,
                                                                width: 1.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10))),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Center(
                                            child: AppButton(
                                              onTap: () async {
                                                if (_loginKey.currentState!
                                                    .validate()) {
                                                  if (_emailController.text
                                                              .trim() ==
                                                          "admin@gmail.com" &&
                                                      _passController.text
                                                              .trim() ==
                                                          "12345678") {
                                                    SharedPreferences _pref =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    _pref.clear();

                                                    _pref.setString('token',
                                                        "admin@gmail.com");
                                                    _pref.setString(
                                                        'name', "admin");
                                                    _pref.setString(
                                                        'phone', "9847543117");
                                                    _pref.setString(
                                                        'type', "admin");
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AdminHomePage(),
                                                            ),
                                                            (route) => false);
                                                  } else {
                                                    _login();
                                                  }
                                                }
                                              },
                                              // child: Container(
                                              //     height: 45,
                                              //     width: 150,
                                              //     decoration: BoxDecoration(
                                              //       borderRadius:
                                              //           BorderRadius.circular(9),
                                              //       color: Colors.red,
                                              //     ),
                                              //     child: Center(
                                              //       child: Text("Login"),
                                              //     )
                                              // ),
                                              text: "Login",
                                              height: 45,
                                              width: 250,
                                              color: Colors.teal,
                                              fontSize: 16,
                                              fontColor: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserRegistration()));
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AppText(data: "New User?"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              AppText(
                                                data: "Register",
                                                color: Colors.red,
                                              ),
                                            ],
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AmbulanceRegistration(
                                                          amp_type: 'private',
                                                        )));
                                          },
                                          child: Column(
                                            children: [
                                              AppText(
                                                  data:
                                                      "Private Ambulance Registration"),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              AppText(
                                                data: "Register",
                                                color: Colors.red,
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                                visible: _isLoading,
                                child: Center(
                                  child:
                                      Lottie.asset('assets/json/loading.json'),
                                )),
                          ],
                        ))),
              )),
            ),
            Visibility(
                visible: _isLoading,
                child: Center(
                  child: Lottie.asset('assets/json/loading.json'),
                ))
          ],
        ));
  }
}
