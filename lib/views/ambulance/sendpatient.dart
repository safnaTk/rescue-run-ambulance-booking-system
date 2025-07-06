// import 'package:flutter/material.dart';
// class SendPatientData extends StatefulWidget {
//   String? hid;
//   SendPatientData({Key? key, this.hid}) : super(key: key);
//
//   @override
//   State<SendPatientData> createState() => _SendPatientDataState();
// }
//
// class _SendPatientDataState extends State<SendPatientData> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green.shade100,
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../models/patientmodel.dart';
import '../../services/ambulanceservice.dart';
import '../../components/appbutton.dart';
import '../../components/customtextformfield.dart';

class SendPatientData extends StatefulWidget {
  String? hid;
  SendPatientData({Key? key, this.hid}) : super(key: key);

  @override
  State<SendPatientData> createState() => _SendPatientDataState();
}

class _SendPatientDataState extends State<SendPatientData> {
  String? sender;
  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    sender = await _pref.getString('ampid');
  }

  @override
  void initState() {
    getData();
    msgid = uuid.v1();
    super.initState();
  }

  // --------Text Editing Controllers..................................
  TextEditingController _ageController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _conditionController = TextEditingController();
  //..............End of  TextEditing Controllers......................

  //----------Form key........................
  final _messageKey = GlobalKey<FormState>();
  bool _isLoading = false;
  var msgid;
  PatientModel _patient = PatientModel();

  var uuid = Uuid();

  AmbulanceService _ambulanceService = AmbulanceService();

  void _sendMessage() async {
    setState(() {
      _isLoading = true;
    });
    _patient = PatientModel(
        msgid: msgid,
        age: _ageController.text,
        remarks: _messageController.text,
        ampid: sender,
        hid: widget.hid,
        address: _addressController.text,
        name: _nameController.text,
        createdat: DateTime.now(),
        condition: _conditionController.text,
        status: 1);

    try {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(Duration(seconds: 4));
      await _ambulanceService
          .sendpatientData(_patient)
          .then((value) => Navigator.pop(context));

      // Navigate to the next page after registration is complete
    } on FirebaseException catch (e) {
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
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Send Patient  Message",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
      ),
      body: SafeArea(
        child: Container(
            decoration: const BoxDecoration(),
            child: Center(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5.0,
                      child: Form(
                        key: _messageKey,
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          height: size.height * 0.80,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  controller: _nameController,
                                  hintText: 'Enter Patient Name',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please a valid name';
                                    }
                                    return null;
                                  },
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      _nameController.clear();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextFormField(
                                  controller: _addressController,
                                  hintText: 'Enter Address',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please address';
                                    }
                                    return null;
                                  },
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      _addressController.clear();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextFormField(
                                  controller: _conditionController,
                                  hintText: 'Enter Patient Condition',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please a valid description';
                                    }
                                    return null;
                                  },
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      _conditionController.clear();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextFormField(
                                  type: TextInputType.number,
                                  controller: _ageController,
                                  hintText: 'Enter Patient Age',
                                  validator: (value) {
                                    if (value!.isEmpty || int.parse(value.toString())<0) {
                                      return 'Please enter a valid Age';
                                    }
                                    return null;
                                  },
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      _ageController.clear();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextFormField(
                                  maxlines: 5,
                                  controller: _messageController,
                                  hintText: 'Any Special Requirements',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter Message';
                                    }
                                    return null;
                                  },
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      _ageController.clear();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: AppButton(
                                    onTap: () {
                                      if (_messageKey.currentState!.validate()) {
                                        _sendMessage();
                                      }
                                    },
                                    text: "Send",
                                    height: 45,
                                    width: 250,
                                    color: Colors.teal.shade900,
                                    fontSize: 16,
                                    fontColor: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: _isLoading,
                      child: Center(
                        child: Lottie.asset('assets/json/loading.json'),
                      ))
                ],
              ),
            )),
      ),
    );
  }
}
