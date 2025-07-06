
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../components/apptext.dart';

class TrackAmbulance extends StatefulWidget {

  String?ampid;
  TrackAmbulance({Key? key,this.ampid}) : super(key: key);

  @override
  State<TrackAmbulance> createState() => _TrackAmbulanceState();
}

class _TrackAmbulanceState extends State<TrackAmbulance> {
  final List<String> _options = [    "on the way",    "reached",    "picked",    "droped",    "completed"  ]; // options for the stepper

  int _currentStep = 0; // current step index, initialized to 0
  Future<DocumentSnapshot> getDocument(String documentId) async {
    // Get a Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Get the document from Firestore using the provided documentId
    DocumentSnapshot document = await firestore.collection('track').doc(documentId).get();

    // Return the document
    return document;
  }
  Future<void> myFunction() async {
    // Get the document with ID 'myDocumentId' from Firestore
    DocumentSnapshot document = await getDocument(widget.ampid.toString());

    if (document.exists) {
      // Get the value of the 'myField' field from the document
      dynamic myFieldValue = document['track'];
      // Do something with the value...
      setState(() {
        currentStatus = myFieldValue;
      });
      print(myFieldValue);
    } else {
      // The document doesn't exist
      print('Document not found!');
    }
  }
  String? currentStatus="on the way";
  @override
  void initState() {
    myFunction();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // assume you get the current status value from the database


    // find the index of the current status in the _options list
    int currentStatusIndex = _options.indexOf(currentStatus!);

    if (currentStatusIndex != -1) {
      _currentStep = currentStatusIndex;
    }
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor:Colors.teal,
        title: AppText(data:"Ambulance Tracking",
          color: Colors.white,
        size: 20,
        fw: FontWeight.bold,),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stepper(

                controlsBuilder: (BuildContext context, ControlsDetails controlsDetails) {
                  return Container(); // Return an empty container to remove the buttons
                },
                currentStep: _currentStep,
                onStepTapped: (int index) {
                  setState(() {
                    _currentStep = index;
                  });
                },
                onStepContinue: () {
                  setState(() {
                    if (_currentStep < _options.length - 1) {
                      _currentStep += 1;
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (_currentStep > 0) {
                      _currentStep -= 1;
                    }
                  });
                },
                steps: _options.map((String option) {
                  return Step(

                    title: AppText(data:option.toUpperCase(),
                      color:Colors.red.shade900,
                      size: 12,fw: FontWeight.bold,),

                    isActive: _options.indexOf(option) <= _currentStep,
                    state: _options.indexOf(option) < _currentStep
                        ? StepState.complete
                        : StepState.indexed,
                    content: Container(),

                  );
                }).toList(),
              ),
            ),
            Expanded(
                child: currentStatus=="completed"
                    ?Lottie.asset('assets/json/completed.json')
                    :Lottie.asset('assets/json/ambulance.json')
            )
          ],
        ),
      ),
    );
  }
}
