
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../constant/colors.dart';
import '../../models/bookingmodel.dart';
import '../../services/ambulanceservice.dart';
import '../../components/appbutton.dart';
import '../../components/customtextformfield.dart';

class BookAmbulanceIP extends StatefulWidget {
  String? ampid;
  String?category;
  String?drivername;
  String?driverPhone;
  GeoPoint?location;
  String?hid;
  BookAmbulanceIP({Key? key, this.hid,this.category,this.ampid,this.driverPhone,this.drivername,this.location}) : super(key: key);

  @override
  State<BookAmbulanceIP> createState() => _BookAmbulanceIPState();
}

class _BookAmbulanceIPState extends State<BookAmbulanceIP> {
  String? sender;
  String? sendername;
  String?email;
  String?phone;
  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    sender = await _pref.getString('uid');
    email = await _pref.getString('email');
    phone = await _pref.getString('phone');
    sendername = await _pref.getString('name');
  }

  @override
  void initState() {
    getData();
    print(widget.category);
    bookingid= uuid.v1();
    super.initState();
  }

  // --------Text Editing Controllers..................................
  TextEditingController _titleController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  TextEditingController _casualController = TextEditingController();
  //..............End of  TextEditing Controllers......................

  //----------Form key........................
  final _messageKey = GlobalKey<FormState>();
  bool _isLoading = false;
  var bookingid;
  BookingModel _message = BookingModel();

  var uuid = Uuid();

  AmbulanceService _ambulanceService = AmbulanceService();

  void _sendMessage() async {
    print(widget.category);
    setState(() {
      _isLoading = true;
    });
    _message = BookingModel(
      bookingid:bookingid,
      hid: widget.hid,
      category: widget.category,
      casualities: _casualController.text,
      senderid: sender,
      senderPhone: phone,
      sendername: sendername,
      senderEmail: email,
      reciverId: widget.ampid,
      receiverPhone: widget.driverPhone,
      location: _messageController.text,
      cause: _titleController.text,
      status: 1,
      date: DateTime.now(),



    );

    try {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(Duration(seconds: 4));
      await _ambulanceService.bookAmbulance(_message)
          .then((value) => Navigator.pop(context));

      // Navigate to the next page after registration is complete
    } on FirebaseException catch (e) {
      setState(() {
        _isLoading = false;
      });

      List err = e.toString().split("]");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: AppColors().primaryColor,
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
    print('this is category${widget.category}');
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Book Ambulance For IP",
          style: TextStyle
            (color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
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
                          height: size.height * 0.42,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  controller: _titleController,
                                  hintText: 'Enter Patient Name',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a Name';
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
                                      _titleController.clear();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextFormField(

                                  controller: _messageController,
                                  hintText: 'Enter location',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter location';
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
                                      _titleController.clear();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextFormField(
                                  type: TextInputType.number,
                                  controller: _casualController,
                                  hintText: 'Transfer Date dd/mm/yy',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a date';
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
                                      _casualController.clear();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Center(
                                  child: AppButton(
                                    onTap: () {
                                      if (_messageKey.currentState!.validate()) {
                                        _sendMessage();
                                      }
                                    },
                                    text: "Book Now",
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
