
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rescuerun/common/Login_page.dart';
import 'package:rescuerun/views/users/user_homepage.dart';

import '../../components/apptext.dart';
import '../../models/usermodel.dart';
import '../../services/userservice.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({super.key});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phonenumberController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();

  bool _visibility = true;
  bool _visibility1 = true;

  final _regkey = GlobalKey<FormState>();

  String? grpvalue;

  UserService _userService = UserService();
  bool _isLoading = false;
  void _register() async {
    setState(() {
      _isLoading = true;
    });
    UserModel user = UserModel(
        name: _nameController.text,
        phone: _phonenumberController.text,
        email: _usernameController.text.trim(),
        password: _passController.text.trim(),
        location: null,
        imgurl: "");

    try {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(Duration(seconds: 4));
      await _userService.registerUser(user).then((value) =>
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage())));

      // Navigate to the next page after registration is complete
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });

      List err = e.toString().split("]");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
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
    }

    // Simulate registration delay
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/images/bg3.jpg',)),
        ),
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Card(
                        color: Colors.white.withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 5.0,
                        child: Form(
                          key: _regkey,
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            height: size.height * 0.75,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "CREATE AN ACCOUNT",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                TextFormField(
                                  style: TextStyle(color:Colors.black),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter a valid name";
                                    }
                                  },
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Colors.teal.shade300
                                    ),
                                    hintText: "Name",

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.cyan.shade500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  style: TextStyle(color:Colors.black),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 10) {
                                      return "Enter a valid phone";
                                    }
                                  },
                                  controller: _phonenumberController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Colors.teal.shade300
                                    ),
                                    hintText: "Phone number",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.cyan.shade500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  style: TextStyle(color:Colors.black),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter a valid email";
                                    }
                                  },
                                  controller: _usernameController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Colors.teal.shade300
                                    ),
                                    hintText: "Email",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.cyan.shade500,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter a valid password";
                                    }
                                  },
                                  style: TextStyle(color:Colors.black),
                                  controller: _passController,
                                  obscureText: _visibility,
                                  obscuringCharacter: "*",
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Colors.teal.shade300
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: (){if (_visibility == true) {
                                        setState(() {
                                          _visibility = false;
                                        });
                                      } else {
                                        setState(() {
                                          _visibility = true;
                                        });
                                      }},
                                      icon: _visibility == true
                                          ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.teal.shade300,
                                      )
                                          : Icon(Icons.visibility,color: Colors.teal.shade300,),
                                    ),
                                    hintText: "Password",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.cyan.shade500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  style: TextStyle(color:Colors.black),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter a valid confirm password";
                                    }
                                  },

                                  controller: _confirmpasswordController,
                                  obscureText: _visibility1,
                                  obscuringCharacter: "*",
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Colors.teal.shade300
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: (){if (_visibility1 == true) {
                                        setState(() {
                                          _visibility1 = false;
                                        });
                                      } else {
                                        setState(() {
                                          _visibility1 = true;
                                        });
                                      }},
                                      icon: _visibility1 == true
                                          ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.teal.shade300,
                                      )
                                          : Icon(Icons.visibility,color: Colors.teal.shade300,),
                                    ),
                                    hintText: "Confirm Password",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color:Colors.cyan.shade500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: InkWell(
                                      onTap: () async {
                                        if (_regkey.currentState!.validate()) {

                                          if (_passController.text ==_confirmpasswordController.text) {
                                             _register();
                                          }
                                          else {
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text("password mismatch"),
                                            ));
                                          }

                                        }
                                      },
                                      child:Container(
                                          height: 55,
                                          width:90,
                                          decoration:BoxDecoration(
                                              color: Colors.teal,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child:Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              AppText(data:"Register",color: Colors.white,fw:FontWeight.bold),
                                            ],

                                          )
                                      )
                                  ),
                                ),

                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppText(data:"Already have an account ?",color: Colors.teal,),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>LoginPage()));
                                      },
                                      child: AppText(
                                        data:"Login",
                                        color: Colors.red,
                                        fw: FontWeight.bold,


                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
                visible: _isLoading,
                child: Center(
                  child: Lottie.asset('assets/json/loading.json'),
                )
            )
          ],
        ),
      ),
    );
    }
}
