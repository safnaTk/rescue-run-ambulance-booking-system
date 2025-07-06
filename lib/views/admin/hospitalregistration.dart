// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// import '../../common/Login_page.dart';
// import '../../models/hospitalmodel.dart';
// import '../../services/hospitalservice.dart';
// import 'adminhomepage.dart';

// class HospitalRegistrations extends StatefulWidget {
//   final Map? snap;
//   final String? name;
//   final String? email;
//   final String? phone;
//   const HospitalRegistrations(
//       {super.key, this.snap, this.name, this.email, this.phone});

//   @override
//   State<HospitalRegistrations> createState() => _HospitalRegistrationsState();
// }

// class _HospitalRegistrationsState extends State<HospitalRegistrations> {
//   TextEditingController _contactController = TextEditingController();
//   TextEditingController _stateController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _pincodeController = TextEditingController();
//   TextEditingController _cityController = TextEditingController();
//   TextEditingController _addressController = TextEditingController();
//   TextEditingController _regnameController = TextEditingController();
//   TextEditingController _pan_numController = TextEditingController();
//   TextEditingController _yearController = TextEditingController();
//   TextEditingController _regdnoController = TextEditingController();
//   TextEditingController _ownershipController = TextEditingController();
//   TextEditingController _websiteController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _cpasswordController = TextEditingController();

//   final _hospregkey = GlobalKey<FormState>();
//   String? grpvalue;
//   bool _visibility = true;
//   bool _visibility1 =true;
//   HospitalService _hospitalService = HospitalService();
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor:Colors.teal,
//         title: Text(
//           "HOSPITAL REGISTRATION",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 15,
//           ),
//         ),
//         leading: Builder(
//           builder: (BuildContext context) {
//             return IconButton(
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => AdminHomePage()));
//               },
//               icon: Icon(
//                 Icons.arrow_back_ios,
//                 size: 30,
//                 color: Colors.white,
//               ),
//             );
//           },
//         ),
//       ),
//       body: Container(
//         child: SafeArea(
//           child: Center(
//             child: Container(
//               padding: EdgeInsets.all(20),
//               height: size.height,
//               width: size.width,
//               child: Form(
//                 key: _hospregkey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         "HOSPITAL REGISTRATION",
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.black,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         width: 500,
//                         child: TextFormField(
//                           style: TextStyle(color: Colors.black),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Enter a valid  Name";
//                             }
//                           },
//                           controller: _regnameController,
//                           keyboardType: TextInputType.name,
//                           decoration: InputDecoration(
//                               labelText: "Hospital name",
//                               hintStyle: TextStyle(color: Colors.black),
//                               hintText: "Hospital Name",
//                               prefixIcon: Icon(
//                                 Icons.local_hospital,
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(color: Colors.black),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide(color: Colors.black))),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 10),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 150,
//                               child: TextFormField(
//                                 keyboardType: TextInputType.number,
//                                 style: TextStyle(color: Colors.black),
//                                 validator: (value) {
//                                   if (value!.length < 3) {
//                                     return "Enter a valid year";
//                                   }
//                                 },
//                                 controller: _yearController,
//                                 decoration: InputDecoration(
//                                     labelText: "Est year",
//                                     hintStyle: TextStyle(color: Colors.black),
//                                     hintText: "Est year",
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide:
//                                           BorderSide(color: Colors.black),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                         borderSide: BorderSide(
//                                             color: Colors.redAccent))),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Container(
//                               width: 130,
//                               child: TextFormField(
//                                 keyboardType: TextInputType.number,
//                                 style: TextStyle(color: Colors.black),
//                                 validator: (value) {
//                                   if (value!.length < 3) {
//                                     return "Enter a valid Regd Number";
//                                   }
//                                 },
//                                 controller: _regdnoController,
//                                 decoration: InputDecoration(
//                                     labelText: "Regd num",
//                                     hintStyle: TextStyle(color: Colors.black),
//                                     hintText: "Regd num",
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide:
//                                           BorderSide(color: Colors.black),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                         borderSide: BorderSide(
//                                             color: Colors.redAccent))),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         width: 500,
//                         child: TextFormField(
//                           style: TextStyle(color: Colors.black),
//                           validator: (value) {
//                             if (value!.length < 3) {
//                               return "Enter a valid value";
//                             }
//                           },
//                           controller: _ownershipController,
//                           // maxLength: 10,
//                           keyboardType: TextInputType.text,
//                           decoration: InputDecoration(
//                               labelText: 'Ownership',
//                               hintStyle: TextStyle(color: Colors.black),
//                               hintText: "Ownership",
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(color: Colors.black),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide:
//                                       BorderSide(color: Colors.redAccent))),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         width: 500,
//                         child: TextFormField(
//                           // keyboardType: TextInputType.number,
//                           style: TextStyle(color: Colors.black),
//                           validator: (value) {
//                             if (value!.length < 3) {
//                               return "Enter a valid pan number";
//                             }
//                           },
//                           controller: _pan_numController,
//                           decoration: InputDecoration(
//                               labelText: 'PAN',
//                               hintStyle: TextStyle(color: Colors.black),
//                               hintText: "PAN",
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(color: Colors.black),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide:
//                                       BorderSide(color: Colors.redAccent))),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                           width: 500,
//                           child: TextFormField(
//                             keyboardType: TextInputType.multiline,
//                             maxLines: 5,
//                             controller: _addressController,
//                             decoration: InputDecoration(
//                                 labelText: 'Address',
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide:
//                                         BorderSide(color: Colors.redAccent))),
//                             validator: (value) {
//                               if (value!.length < 3) {
//                                 return 'enter a valid address';
//                               }
//                             },
//                           )),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         width: 500,
//                         child: TextFormField(
//                           keyboardType: TextInputType.text,
//                           style: TextStyle(color: Colors.black),
//                           validator: (value) {
//                             if (value!.length < 3) {
//                               return "Enter a city";
//                             }
//                           },
//                           controller: _cityController,
//                           decoration: InputDecoration(
//                               labelText: "City",
//                               hintStyle: TextStyle(color: Colors.black),
//                               hintText: "City",
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(color: Colors.black),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide:
//                                       BorderSide(color: Colors.redAccent))),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         width: 500,
//                         child: TextFormField(
//                           keyboardType: TextInputType.text,
//                           style: TextStyle(color: Colors.black),
//                           validator: (value) {
//                             if (value!.length < 3) {
//                               return "Enter a State";
//                             }
//                           },
//                           controller: _stateController,
//                           decoration: InputDecoration(
//                               labelText: 'State',
//                               hintStyle: TextStyle(color: Colors.black),
//                               hintText: "State",
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(color: Colors.black),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide:
//                                       BorderSide(color: Colors.redAccent))),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         width: 500,
//                         child: TextFormField(
//                           keyboardType: TextInputType.number,
//                           style: TextStyle(color: Colors.black),
//                           validator: (value) {
//                             if (value!.length < 3) {
//                               return "Enter a Pin code";
//                             }
//                           },
//                           controller: _pincodeController,
//                           decoration: InputDecoration(
//                               labelText: 'Pincode',
//                               hintStyle: TextStyle(color: Colors.black),
//                               hintText: "Pincode",
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(color: Colors.black),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide:
//                                       BorderSide(color: Colors.redAccent))),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         width: 500,
//                         child: TextFormField(
//                           keyboardType: TextInputType.number,
//                           style: TextStyle(color: Colors.black),
//                           validator: (value) {
//                             if ((value!.length) != 11) {
//                               return "Enter a contact";
//                             }
//                           },
//                           controller: _contactController,
//                           decoration: InputDecoration(
//                               labelText: 'Contact',
//                               hintStyle: TextStyle(color: Colors.black),
//                               hintText: "Contact",
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(color: Colors.black),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide:
//                                   BorderSide(color: Colors.redAccent))),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         width: 500,
//                         child: TextFormField(
//                           keyboardType: TextInputType.emailAddress,
//                           style: TextStyle(color: Colors.black),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Enter a valid Email";
//                             }
//                           },
//                           controller: _emailController,
//                           decoration: InputDecoration(
//                               labelText: 'Email',
//                               prefixIcon: Icon(
//                                 Icons.email,
//                               ),
//                               hintStyle: TextStyle(color: Colors.black),
//                               hintText: "Enter a valid Email",
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(color: Colors.black),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide:
//                                       BorderSide(color: Colors.redAccent))),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         width: 500,
//                         child: TextFormField(
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Enter a valid password";
//                             }
//                           },
//                           style: TextStyle(color:Colors.black),
//                           controller: _passwordController,
//                           obscureText: _visibility,
//                           obscuringCharacter: "*",
//                           decoration: InputDecoration(
//                             hintStyle: TextStyle(
//                                 color: Colors.teal.shade300
//                             ),
//                             suffixIcon: IconButton(
//                               onPressed: (){if (_visibility == true) {
//                                 setState(() {
//                                   _visibility = false;
//                                 });
//                               } else {
//                                 setState(() {
//                                   _visibility = true;
//                                 });
//                               }},
//                               icon: _visibility == true
//                                   ? Icon(
//                                 Icons.visibility_off,
//                                 color: Colors.teal.shade300,
//                               )
//                                   : Icon(Icons.visibility,color: Colors.teal.shade300,),
//                             ),
//                             hintText: "Password",
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                 color: Colors.blueGrey,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                 color: Colors.cyan.shade500,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         width: 500,
//                         child: TextFormField(
//                           style: TextStyle(color:Colors.black),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Enter a valid confirm password";
//                             }
//                           },

//                           controller: _cpasswordController,
//                           obscureText: _visibility1,
//                           obscuringCharacter: "*",
//                           decoration: InputDecoration(
//                             hintStyle: TextStyle(
//                                 color: Colors.teal.shade300
//                             ),
//                             suffixIcon: IconButton(
//                               onPressed: (){if (_visibility1 == true) {
//                                 setState(() {
//                                   _visibility1 = false;
//                                 });
//                               } else {
//                                 setState(() {
//                                   _visibility1 = true;
//                                 });
//                               }},
//                               icon: _visibility1 == true
//                                   ? Icon(
//                                 Icons.visibility_off,
//                                 color: Colors.teal.shade300,
//                               )
//                                   : Icon(Icons.visibility,color: Colors.teal.shade300,),
//                             ),
//                             hintText: "Confirm Password",
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                 color: Colors.blueGrey,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                 color:Colors.cyan.shade500,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Container(
//                         width: 500,
//                         child: TextFormField(
//                           style: TextStyle(color: Colors.black),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Enter a website";
//                             }
//                           },
//                           controller: _websiteController,
//                           decoration: InputDecoration(
//                               labelText: 'Website',
//                               hintStyle: TextStyle(color: Colors.black),
//                               hintText: "Website",
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: BorderSide(color: Colors.black),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide:
//                                       BorderSide(color: Colors.redAccent))),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Center(
//                         child: InkWell(
//                             onTap: () {
//                               if (_hospregkey.currentState!.validate()) {
//                                  _register();

//                               }
//                               // else{
//                               //   ScaffoldMessenger.of(context)
//                               //       .showSnackBar(
//                               //       SnackBar(
//                               //         backgroundColor: Colors.red,
//                               //         content: Text("Password mismatch"),
//                               //       ));
//                               // }

//                               // Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //         builder: (context) =>
//                               //             LoginPage()));
//                             },
//                             child: Container(
//                               height: 55,
//                               width: 90,
//                               decoration: BoxDecoration(
//                                 color: Colors.redAccent,
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "Register",
//                                     style: TextStyle(
//                                       color: Colors.blue.shade100,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )),
//                       ),
//                       Visibility(
//                           visible: _isLoading,
//                           child: Center(
//                             child: Lottie.asset('assets/json/loading.json'),
//                           )),
//                       SizedBox(
//                         height: 30,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   _showpassword() {
//     if (_visibility == true) {
//       setState(() {
//         _visibility = false;
//       });
//     } else {
//       setState(() {
//         _visibility = true;
//       });
//     }
//   }
//   bool _isLoading = false;

//   void _register() async {
//     setState(() {
//       _isLoading = true;
//     });

//     HospitalModel hospital = HospitalModel(
//       email: _emailController.text,
//       hname: _regnameController.text,
//       estyear: _yearController.text,
//       regno: _regdnoController.text,
//       ownership: _ownershipController.text,
//       pan_no: _pan_numController.text,
//       address: _addressController.text,
//       city: _cityController.text,
//       state: _stateController.text,
//       pincode: _pincodeController.text,
//       contactno: _contactController.text,
//       website: _websiteController.text,
//       password: _passwordController.text,
//     );
//     try {
//       setState(() {
//         _isLoading = true;
//       });
//       await Future.delayed(Duration(seconds: 4));
//       await _hospitalService
//           .registerUser(hospital)
//           .then((value) => Navigator.pop(context));

//       // Navigate to the next page after registration is complete
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         _isLoading = false;
//       });

//       List err = e.toString().split("]");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: Colors.red,
//           duration: Duration(seconds: 3),
//           content: Container(
//             height: 85,
//             child: Center(
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.amber,
//                     child: Icon(
//                       Icons.warning,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Expanded(child: Text(err[1].toString())),
//                   // Expanded(child: Text("Registered")),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     // Simulate registration delay
//   }
// }
//is the booking and all functionalities still work using this code
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rescuerun/controller/hosptalregistrationcontroller.dart';
import 'package:rescuerun/models/hospitalmodel.dart';
import 'package:rescuerun/views/admin/adminhomepage.dart';

class HospitalRegistrations extends StatefulWidget {
  const HospitalRegistrations({super.key});

  @override
  State<HospitalRegistrations> createState() => _HospitalRegistrationsState();
}

class _HospitalRegistrationsState extends State<HospitalRegistrations> {
  final _formKey = GlobalKey<FormState>();

  final _hnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _estYearController = TextEditingController();
  final _regNoController = TextEditingController();
  final _ownershipController = TextEditingController();
  final _panNoController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _contactController = TextEditingController();
  final _websiteController = TextEditingController();

  Future<void> _submitForm(HospitalRegistrationController controller) async {
    print("🚀 Submit button pressed");

    if (!_formKey.currentState!.validate()) return;

    final hospital = HospitalModel(
      hname: _hnameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      estyear: _estYearController.text.trim(),
      regno: _regNoController.text.trim(),
      ownership: _ownershipController.text.trim(),
      pan_no: _panNoController.text.trim(),
      address: _addressController.text.trim(),
      city: _cityController.text.trim(),
      state: _stateController.text.trim(),
      pincode: _pincodeController.text.trim(),
      contactno: _contactController.text.trim(),
      website: _websiteController.text.trim(),
      imgurl: "",
    );

    final error = await controller.registerHospital(hospital);

    if (error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Hospital registered successfully!")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminHomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register Hospital")),
      body: Consumer<HospitalRegistrationController>(
        builder: (context, controller, _) {
          print("🎯 Rebuilding UI - isLoading: ${controller.isLoading}");

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildField(_hnameController, "Hospital Name"),
                    buildEmailField(),
                    buildPasswordField(),
                    buildField(_estYearController, "Establishment Year"),
                    buildField(_regNoController, "Registration Number"),
                    buildField(_ownershipController, "Ownership Type"),
                    buildField(_panNoController, "PAN Number"),
                    buildField(_addressController, "Address"),
                    buildField(_cityController, "City"),
                    buildField(_stateController, "State"),
                    buildPincodeField(),
                    buildContactField(),
                    buildWebsiteField(),
                    const SizedBox(height: 20),

                    /// ✅ FIXED BUTTON WITH LOADING INDICATOR
                    ElevatedButton(
                      onPressed: controller.isLoading
                          ? null
                          : () => _submitForm(controller),
                      child: controller.isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text("Register Hospital"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: (value) =>
          value == null || value.trim().isEmpty ? "$label is required" : null,
    );
  }

  Widget buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(labelText: "Email"),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.trim().isEmpty) return "Email is required";
        if (!value.contains("@") || !value.contains(".")) {
          return "Enter a valid email";
        }
        return null;
      },
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(labelText: "Password"),
      obscureText: true,
      validator: (value) =>
          value != null && value.length >= 6 ? null : "Min 6 characters",
    );
  }

  Widget buildPincodeField() {
    return TextFormField(
      controller: _pincodeController,
      decoration: const InputDecoration(labelText: "Pincode"),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) return "Pincode is required";
        if (value.length != 6) return "Enter a valid 6-digit pincode";
        return null;
      },
    );
  }

  Widget buildContactField() {
    return TextFormField(
      controller: _contactController,
      decoration: const InputDecoration(labelText: "Contact Number"),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) return "Contact number is required";
        if (value.length != 10) return "Enter a valid 10-digit number";
        return null;
      },
    );
  }

  Widget buildWebsiteField() {
    return TextFormField(
      controller: _websiteController,
      decoration: const InputDecoration(labelText: "Website (optional)"),
      validator: (value) {
        if (value != null && value.isNotEmpty && !value.contains(".")) {
          return "Enter a valid website or leave it blank";
        }
        return null;
      },
    );
  }
}
