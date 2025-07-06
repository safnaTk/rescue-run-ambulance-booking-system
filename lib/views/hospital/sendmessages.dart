
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../models/messagemodel.dart';
import '../../services/ambulanceservice.dart';
import '../../components/appbutton.dart';
import '../../components/customtextformfield.dart';

class SendMessage extends StatefulWidget {
  String? ampid;
  SendMessage({Key? key, this.ampid}) : super(key: key);

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  String? sender;
  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    sender = await _pref.getString('hid');
  }

  @override
  void initState() {
    getData();
    msgid = uuid.v1();
    super.initState();
  }

  // --------Text Editing Controllers..................................
  TextEditingController _titleController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  //..............End of  TextEditing Controllers......................

  //----------Form key........................
  final _messageKey = GlobalKey<FormState>();
  bool _isLoading = false;
  var msgid;
  MessageModel _message = MessageModel();

  var uuid = Uuid();

  AmbulanceService _ambulanceService = AmbulanceService();

  void _sendMessage() async {
    setState(() {
      _isLoading = true;
    });
    _message = MessageModel(
        msgid: msgid,
        title: _titleController.text,
        message: _messageController.text,
        sender: sender,
        receiver: widget.ampid,
        status: 1);

    try {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(Duration(seconds: 4));
      await _ambulanceService
          .sendMessage(_message)
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
        title: Text(
          "Send Message",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
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
                          child: Column(
                            children: [
                              CustomTextFormField(
                                controller: _titleController,
                                hintText: 'Enter a title',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a Title';
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
                                maxlines: 5,
                                controller: _messageController,
                                hintText: 'Enter Message',
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
                                    _titleController.clear();
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
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
                                  color:Colors.teal,
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
