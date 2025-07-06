// screens/ambulance/ambulance_registration.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rescuerun/controller/ambulanceregistration_controller.dart';
import 'package:rescuerun/models/ambulancemodel.dart';

class AmbulanceRegistration extends StatefulWidget {
  final String amp_type;
  final String? ownerId;

  const AmbulanceRegistration({
    super.key,
    required this.amp_type,
    this.ownerId,
  });

  @override
  State<AmbulanceRegistration> createState() => _AmbulanceRegistrationState();
}

class _AmbulanceRegistrationState extends State<AmbulanceRegistration> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController driverNameCtrl = TextEditingController();
  final TextEditingController driverPhoneCtrl = TextEditingController();
  final TextEditingController regNoCtrl = TextEditingController();
  final TextEditingController ownerNameCtrl = TextEditingController();
  final TextEditingController ownerPhoneCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  String? category;

  final List<String> categories = [
    "Basic Life Support",
    "Advance Life Support",
    "Patient Transfer",
    "Mortuary"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ambulance Registration")),
      body: Consumer<AmbulanceRegistrationController>(
        builder: (context, controller, _) => controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: driverNameCtrl,
                        decoration: const InputDecoration(labelText: "Driver Name"),
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                      TextFormField(
                        controller: driverPhoneCtrl,
                        decoration: const InputDecoration(labelText: "Driver Phone"),
                        keyboardType: TextInputType.phone,
                        validator: (v) => v!.length != 10 ? 'Enter valid number' : null,
                      ),
                      TextFormField(
                        controller: regNoCtrl,
                        decoration: const InputDecoration(labelText: "Ambulance Reg No"),
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                      TextFormField(
                        controller: ownerNameCtrl,
                        decoration: const InputDecoration(labelText: "Owner Name"),
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                      TextFormField(
                        controller: ownerPhoneCtrl,
                        decoration: const InputDecoration(labelText: "Owner Phone"),
                        keyboardType: TextInputType.phone,
                        validator: (v) => v!.length != 10 ? 'Enter valid number' : null,
                      ),
                      TextFormField(
                        controller: emailCtrl,
                        decoration: const InputDecoration(labelText: "Email"),
                        validator: (v) => v!.contains("@") ? null : 'Invalid Email',
                      ),
                      TextFormField(
                        controller: passwordCtrl,
                        decoration: const InputDecoration(labelText: "Password"),
                        obscureText: true,
                        validator: (v) => v!.length < 6 ? 'Min 6 characters' : null,
                      ),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'Category'),
                        items: categories.map((cat) => DropdownMenuItem(
                              value: cat,
                              child: Text(cat),
                            )).toList(),
                        onChanged: (val) => category = val,
                        validator: (val) => val == null ? 'Select category' : null,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final ambulance = AmbulanceModel(
                              driverName: driverNameCtrl.text,
                              driverPhone: driverPhoneCtrl.text,
                              ampRegNo: regNoCtrl.text,
                              ownerName: ownerNameCtrl.text,
                              ownerPhone: ownerPhoneCtrl.text,
                              email: emailCtrl.text.trim(),
                              password: passwordCtrl.text.trim(),
                              category: category,
                              type: widget.amp_type,
                              status: 1,
                              avilableStatus: 1,
                              ownerid: widget.amp_type == 'hospital' ? widget.ownerId : null,
                            );

                            final error = await controller.registerAmbulance(ambulance);

                            if (error == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Registration Successful")),
                              );
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error: $error")),
                              );
                            }
                          }
                        },
                        child: const Text("Register"),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:rescuerun/utils/apptext.dart';
// import 'package:rescuerun/screens/ambulance/ambulance_homepage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../common/Login_page.dart';
// import '../../constant/colors.dart';
// import '../../models/ambulancemodel.dart';
// import '../../services/ambulanceservice.dart';
// import '../users/user_homepage.dart';

// class AmbulanceRegistration extends StatefulWidget {
//   final Map?snap;
//   final String? name;
//   final String? email;
//   final String? phone;
//   final String?amp_tytpe;
//   const AmbulanceRegistration({super.key,this.snap,this.name,this.email,this.phone,this.amp_tytpe});

//   @override
//   State<AmbulanceRegistration> createState() => _AmbulanceRegistrationState();
// }

// class _AmbulanceRegistrationState extends State<AmbulanceRegistration> {
//   TextEditingController _dregnameController = TextEditingController();
//   TextEditingController _dregphonenumberController = TextEditingController();
//   TextEditingController _dregnumController = TextEditingController();
//   TextEditingController _dlicencenumController = TextEditingController();
//   TextEditingController _dlocationController = TextEditingController();
//   TextEditingController _drcController = TextEditingController();
//   TextEditingController _downregphonenumController = TextEditingController();
//   TextEditingController _demailController = TextEditingController();
//   TextEditingController _descController = TextEditingController();
//   TextEditingController _dpasswordController = TextEditingController();
//   TextEditingController _dconfirmpasswordController = TextEditingController();
//   String? _selectedOption;
//   bool _visibility1=true;

//   String? hid;
//   getData() async {
//     SharedPreferences _pref = await SharedPreferences.getInstance();

//     hid = await _pref.getString('hid');
//   }
//   final List<String> _options = [
//     "Basic Life Support Ambulance",
//     "Advance Life Support Ambulance",
//     "Patient Transfer Ambulance",
//     "Mortuary Ambulance"];

//   AmbulanceService _ambulanceService = AmbulanceService();

//   @override
//   void initState() {
//     getData();
//     super.initState();
//   }
//   final _ambregkey = GlobalKey<FormState>();
//   String? grpvalue;
//   bool _visibility = true;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor:Colors.green.shade100,
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: Text(
//           "AMBULANCE REGISTRATION",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 15,
//           ),

//         ),

//       ),
//       body: Container(
//         // decoration: BoxDecoration(
//         //   image: DecorationImage(
//         //     fit: BoxFit.cover,
//         //     image: AssetImage('assets/images/bg3.jpg',),
//         //   ),
//         // ),
//         child: SafeArea(
//           child: Center(
//             child: Stack
//               (
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(20),
//                   height: size.height,
//                   width: size.width,
//                   child: Form(
//                     key: _ambregkey,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             "AMBULANCE REGISTRATION",
//                             style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.blue.shade900,
//                               fontWeight: FontWeight.w800,
//                             ),),

//                           SizedBox(
//                             height: 20,
//                           ),
//                           TextFormField(
//                             style: TextStyle(color: Colors.blue.shade900),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return "Enter a valid Driver Name";
//                               }
//                             },
//                             controller: _dregnameController,
//                             keyboardType: TextInputType.name,
//                             decoration: InputDecoration(
//                                 labelText:"driver name",
//                                 hintStyle: TextStyle(color: Colors.black),
//                                 hintText: "Driver Name",
//                                 prefixIcon: Icon(
//                                   Icons.person,
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide:
//                                     BorderSide(color: Colors.black))),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           TextFormField(
//                             keyboardType: TextInputType.number,
//                             style: TextStyle(color: Colors.blue.shade900),
//                             validator: (value) {
//                               if (value!.isEmpty || value.length < 10) {
//                                 return "Enter a valid Driver Phone Number";
//                               }
//                             },
//                             controller: _dregphonenumberController,
//                             decoration: InputDecoration(
//                                 labelText:"driver phone number",
//                                 hintStyle: TextStyle(color: Colors.black),
//                                 hintText: "Driver Phone Number",
//                                 prefixIcon: Icon(
//                                   Icons.contact_page_rounded,
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide:
//                                     BorderSide(color: Colors.redAccent))),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             width: 500,
//                             child: TextFormField(
//                               style: TextStyle(color: Colors.blue.shade900),
//                               validator: (value) {
//                                 if (value!.isEmpty ) {
//                                   return "Enter a valid Reg Number";
//                                 }
//                               },
//                               controller: _drcController,
//                               keyboardType: TextInputType.text,
//                               decoration: InputDecoration(
//                                   hintStyle: TextStyle(color: Colors.black),
//                                   hintText: "KL-53M-1000",
//                                   labelText: 'Ambulance Reg Number',
//                                   prefixIcon: Icon(
//                                     Icons.directions_bus_filled_rounded,
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide(color: Colors.black),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide:
//                                       BorderSide(color: Colors.redAccent))),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             width: 500,
//                             child: TextFormField(
//                               style: TextStyle(color: Colors.blue.shade900),
//                               validator: (value) {
//                                 if (value!.length != 10) {
//                                   return "Enter a valid Driver Licence Number";
//                                 }
//                               },
//                               controller: _dlicencenumController,
//                               maxLength: 10,
//                               // keyboardType: TextInputType.number,
//                               decoration: InputDecoration(
//                                   labelText: 'Driver Licence Number',
//                                   prefixIcon: Icon(
//                                     Icons.add_card_outlined,
//                                   ),
//                                   hintStyle: TextStyle(color: Colors.black),
//                                   hintText: "Driver Licence Number",
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide(color: Colors.black),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide:
//                                       BorderSide(color: Colors.redAccent))),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             width: 500,
//                             child: TextFormField(
//                               style: TextStyle(color: Colors.blue.shade900),
//                               validator: (value) {
//                                 if (value!.length < 3) {
//                                   return "Enter a valid location";
//                                 }
//                               },
//                               controller: _dlocationController,
//                               decoration: InputDecoration(
//                                   labelText: 'location',
//                                   prefixIcon: Icon(
//                                     Icons.location_on_outlined,
//                                   ),
//                                   hintStyle: TextStyle(color: Colors.black),
//                                   hintText: "location",
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide(color: Colors.black),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide:
//                                       BorderSide(color: Colors.redAccent))),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                               width: 500,
//                               child: TextFormField(
//                                 style: TextStyle(color: Colors.blue.shade900),
//                                 keyboardType: TextInputType.multiline,
//                                 maxLines: 5,
//                                 controller: _descController,
//                                 decoration: InputDecoration(
//                                     labelText: 'Owner/Address/License number',
//                                     prefixIcon: Icon(
//                                       Icons.description_rounded,
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide: BorderSide(color: Colors.black),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                         borderSide:
//                                         BorderSide(color: Colors.redAccent))),
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'enter a valid des';
//                                   }
//                                 },
//                               )),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             width: 500,
//                             child: TextFormField(
//                               keyboardType: TextInputType.number,
//                               style: TextStyle(color: Colors.blue.shade900),
//                               validator: (value) {
//                                 if (value!.isEmpty || value.length < 10) {
//                                   return "Enter a valid Owner Phone Number";
//                                 }
//                               },
//                               controller: _downregphonenumController,
//                               decoration: InputDecoration(
//                                   labelText: "Owner Phone Number",
//                                   prefixIcon: Icon(
//                                     Icons.contact_page_rounded,
//                                   ),

//                                   hintStyle: TextStyle(color: Colors.black),
//                                   hintText: "Owner Phone Number",
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide(color: Colors.black),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide:
//                                       BorderSide(color: Colors.redAccent))),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             width: 500,
//                             child: TextFormField(
//                               keyboardType: TextInputType.emailAddress,
//                               style: TextStyle(color: Colors.blue.shade900),
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return "Enter a valid Email";
//                                 }
//                               },
//                               controller: _demailController,
//                               decoration: InputDecoration(
//                                   labelText: 'Email',
//                                   prefixIcon: Icon(
//                                     Icons.email,
//                                   ),
//                                   hintStyle: TextStyle(color: Colors.black),
//                                   hintText: "Enter a valid Email",
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide(color: Colors.black),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide:
//                                       BorderSide(color: Colors.redAccent))),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(

//                             width: 500,
//                             child: TextFormField(
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return "password is required";
//                                 }
//                               },
//                               style: TextStyle(color: Colors.blue.shade900),
//                               controller: _dpasswordController,
//                               obscureText: _visibility,
//                               obscuringCharacter: "*",
//                               decoration: InputDecoration(
//                                   prefixIcon: Icon(
//                                     Icons.lock,
//                                   ),
//                                   labelText: 'Password',

//                                   hintStyle: TextStyle(color: Colors.black),
//                                   suffixIcon: IconButton(
//                                     onPressed: _showpassword,
//                                     icon: _visibility == true
//                                         ? Icon(Icons.visibility_off)
//                                         : Icon(Icons.visibility),
//                                   ),
//                                   hintText: "Password",
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide(color: Colors.black),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide:
//                                       BorderSide(color: Colors.redAccent))),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             width:500,
//                             child: TextFormField(
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return "Enter a valid confirm password";
//                                 }
//                               },
//                               style: TextStyle(color: Colors.blue.shade900),
//                               controller: _dconfirmpasswordController,
//                               obscureText: _visibility1,
//                               obscuringCharacter: "*",
//                               decoration: InputDecoration(
//                                   labelText: 'Confirm Password',
//                                   prefixIcon: Icon(
//                                     Icons.lock,
//                                   ),
//                                   suffixIcon: IconButton(
//                                     onPressed: (){if (_visibility1 == true) {
//                                       setState(() {
//                                         _visibility1 = false;
//                                       });
//                                     } else {
//                                       setState(() {
//                                         _visibility1 = true;
//                                       });
//                                     }},
//                                     icon: _visibility1 == true
//                                         ? Icon(
//                                       Icons.visibility_off,
//                                       color: Colors.teal.shade300,
//                                     )
//                                         : Icon(Icons.visibility,color: Colors.teal.shade300,),
//                                   ),
//                                   hintStyle: TextStyle(color: Colors.black),
//                                   hintText: "Confirm Password",
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide(color: Colors.black),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide:
//                                       BorderSide(color: Colors.redAccent))),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             width: 500,
//                             child: DropdownButtonFormField<String>(
//                               decoration: InputDecoration(
//                                 labelText: 'Select an option',
//                                 border: OutlineInputBorder(),
//                               ),
//                               value: _selectedOption,
//                               items: _options
//                                   .map(
//                                     (option) => DropdownMenuItem<String>(
//                                   value: option,
//                                   child: Text(option),
//                                 ),
//                               )
//                                   .toList(),
//                               onChanged: (value) {
//                                 setState(() {
//                                   _selectedOption = value;
//                                 });
//                               },
//                               validator: (value) {
//                                 if (value == null) {
//                                   return 'Please select an option';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Center(
//                             child: InkWell(
//                                 onTap: () {
//                                   if (_ambregkey.currentState!.validate()) {
//                                     if (_dpasswordController.text ==
//                                         _dconfirmpasswordController.text) {
//                                       _register();
//                                     } else {
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(SnackBar(
//                                         content: Text("password mismatch"),
//                                       ));
//                                     }

//                                   }
//                                 },
//                                 child: Container(
//                                   height: 55,
//                                   width: 90,
//                                   decoration: BoxDecoration(
//                                     color: Colors.blue.shade900,
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "Register",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                         ),

//                                       ),
//                                     ],
//                                   ),
//                                 )),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Already have an account ?",
//                                 style: TextStyle(color: Colors.blue,fontSize: 15,fontWeight:FontWeight.bold),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               LoginPage()));
//                                 },
//                                 child: Text(
//                                   "Login",
//                                   style: TextStyle(
//                                     color: Colors.red,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 15,

//                                   ),

//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                     visible: _isLoading,
//                     child: Center(
//                       child: Lottie.asset('assets/json/loading.json'),
//                     )
//                 )
//               ],
//             )
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

//     AmbulanceModel ambulance = AmbulanceModel(
//         type: widget.amp_tytpe==null?"private":widget.amp_tytpe,
//         driverName: _dregnameController.text,
//         driverPhone: _dregphonenumberController.text,
//         ampRegNo: _drcController.text,
//         ownerName: _descController.text,
//         ownerPhone: _downregphonenumController.text,
//         email: _demailController.text.trim(),
//         category: _selectedOption,
//         password: _dpasswordController.text.trim(),
//         status: 1,
//         driverLicence: _dlicencenumController.text,
//         avilableStatus: 1,
//         location: null,
//         ownerid:widget.amp_tytpe=='hospital'?hid:null
//     );
//     try {
//       setState(() {
//         _isLoading = true;
//       });
//       await Future.delayed(Duration(seconds: 4));
//       await _ambulanceService
//           .registerAmbulance(ambulance)
//           .then((value) => Navigator.pop(context));

//       // Navigate to the next page after registration is complete
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         _isLoading = false;
//       });

//       List err = e.toString().split("]");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: AppColors().primaryColor,
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
