
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rescuerun/common/Login_page.dart';
import 'package:rescuerun/views/ambulance/sendemergencymessage.dart';
import 'package:rescuerun/views/ambulance/sendpatient.dart';
import 'package:rescuerun/views/ambulance/vieallmessagesambulance.dart';
import 'package:rescuerun/views/ambulance/viewallbookingambulance.dart';
import 'package:rescuerun/views/ambulance/viewallipbookings.dart';
import 'package:rescuerun/views/hospital/allmessages.dart';
import 'package:rescuerun/views/hospital/viewallbookinghospip.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/apptext.dart';
import '../../models/ambulancemodel.dart';
import '../../services/ambulanceservice.dart';
import '../../services/userservice.dart';
import '../../components/customcontainer.dart';
import '../hospital/viewallambulances.dart';
import '../users/viewallnotificationuser.dart';
import 'location.dart';
class AmbulanceHomePage extends StatefulWidget {
  final Map? snap;
  final String?name;
  final String?email;
  final String?phone;
  const AmbulanceHomePage(
      {Key? key, this.snap, this.name, this.email, this.phone})
      : super(key: key);

  @override
  State<AmbulanceHomePage> createState() => _AmbulanceHomePageState();
}

class _AmbulanceHomePageState extends State<AmbulanceHomePage> {
  var ampid;
  var hid;
  var amp_type;
  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    ampid = await _pref.getString('ampid');
    hid = await _pref.getString('hid');
    amp_type=await _pref.getString('amp_type');

    setState(() {});
  }

  UserService userService = UserService();

  AmbulanceService _ambulanceService=AmbulanceService();
  //
  @override
  void initState() {
    getData();
    super.initState();
  }

  final List<String> _options = [
    "on the way",
    "reached",
    "picked",
    "droped",
    "completed"
  ];
  @override
  Widget build(BuildContext context) {
    print("************ ${amp_type}**********");
    return Scaffold(
      backgroundColor: Colors.teal.shade100,
      appBar: AppBar(
        title: Text("Ambulance",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),

        backgroundColor: Colors.teal,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewAllNotificationUser()));
              },
              icon: FaIcon(
                FontAwesomeIcons.bell,
                color: Colors.yellow,
              )),
          IconButton(onPressed: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
          },
              icon: FaIcon(FontAwesomeIcons.arrowRightFromBracket,color: Colors.yellowAccent,)),

        ],
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                data: "Dashboard",
                size: 25,
                fw: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
              const SizedBox(
                height: 20,
              ),
              amp_type=='hospital'
                  ? Row(
                children: [
                  Expanded(
                    child: CustomContainer(
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewAllMessagesAmbulance(
                                  ampid:ampid
                                )));
                      },
                      height: 85,
                      width: 200,
                      color: Colors.blue.shade900,
                      child: Center(
                        child: AppText(
                          data: "View Messsages",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: CustomContainer(
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SendEmergencyMessage(
                                  hid: hid,
                                )));
                      },
                      height: 85,
                      width: 200,
                      color: Colors.blue.shade900,
                      child: Center(
                        child: AppText(
                          data: "Emergency \nMesssages",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ):SizedBox(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  amp_type=='hospital'?  Expanded(
                    child: CustomContainer(
                      ontap: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SendPatientData(
                          hid: hid,
                        )));

                      },
                      height: 85,
                      width: 200,
                      color: Colors.blue.shade900,
                      child: Center(
                        child: AppText(
                          data: "Send Patient\n data",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ):SizedBox(),
                  const SizedBox(
                    width: 15,
                  ),








                  SizedBox(width: 15,),


                  Expanded(
                    child: CustomContainer(
                      ontap: () {
                        var _selectedOption;
                        showDialog(context: context, builder: (context){

                          return AlertDialog(
                            content: Container(
                              height: 150,
                              child:   Column(
                                children: [
                                  Container(
                                    width: 300,
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Select an option',
                                        border: OutlineInputBorder(),
                                      ),
                                      value: _selectedOption,
                                      items: _options
                                          .map(
                                            (option) => DropdownMenuItem
                                            <String>(
                                          value: option,
                                          child: Text(option),
                                        ),
                                      )
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedOption = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please select an option';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 25,),


                                  CustomContainer(
                                    ontap: () {

                                      if(_selectedOption=="completed"){
                                        FirebaseFirestore.instance.collection('track').doc(ampid).update({
                                          'track':_selectedOption,
                                          'status':0
                                        }).then((value) {
                                          AmbulanceModel _ambulanceModel=AmbulanceModel(ampid: ampid);

                                          _ambulanceService.resetAvailability(_ambulanceModel);


                                        }).then((value) => Navigator.pop(context));
                                      }
                                      else{

                                        FirebaseFirestore.instance.collection('track').doc(ampid).update({
                                          'track':_selectedOption,
                                          'status':0
                                        }).then((value) => Navigator.pop(context));
                                      }

                                    },
                                    height: 50,
                                    width: 250,
                                    decoration: BoxDecoration(
                                        color:Colors.blue.shade900,
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Center(
                                        child: AppText(
                                          data: "Update",
                                          color: Colors.white,
                                        )),
                                  ),
                                ],
                              ),




                            ),
                          );
                        });



                      },
                      height: 85,
                      width: 200,
                      color: Colors.blue.shade900,
                      child: Center(
                        child: AppText(
                          data: "Update Status",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ,
              SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  Expanded(
                    child: CustomContainer(
                      ontap: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>ViewAllBookingAmbulance(
                                  id: ampid,
                                )));

                      },
                      height: 85,
                      width: 200,
                      color: Colors.blue.shade900,
                      child: Center(
                        child: AppText(
                          data: "View Bookings",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CustomContainer(
                      ontap: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>ViewAllIpBookingAmbulance(
                                  id: ampid,
                                )));

                      },
                      height: 85,
                      width: 200,
                      color: Colors.blue.shade900,
                      child: Center(
                        child: AppText(
                          data: "View IP Bookings",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                ],
              ),



              SizedBox(
                height:25,
              ),


                    //
              amp_type=='private'?
              CustomContainer(
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewAllAmbulances(hid: hid,)
                      ),
                  );
                },
                height: 85,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      data: "View Feedback",
                      color: Colors.white,
                    )
                  ],
                ),
              ):SizedBox(),
              const SizedBox(
                width: 15,
              ),




              SizedBox(
                height:50,
              ),
              Center(
                child: AppText(
                  data: "Update Location",
                  size: 18,
                  fw: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: InkWell(

                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocationPage(
                              ampid: ampid,

                            )));

                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blue.shade900),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.locationPin,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
