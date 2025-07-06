import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rescuerun/views/users/sendfeedback.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/colors.dart';
import '../../models/ambulancemodel.dart';
import '../../services/ambulanceservice.dart';
import '../../components/apptext.dart';
import '../../components/customcontainer.dart';
import 'ambulancebook.dart';
import 'bookambulanceip.dart';

class ViewAllAmbulancesUser extends StatefulWidget {
  String? type;
  String? cat;
  ViewAllAmbulancesUser({Key? key, this.type, this.cat = "emergency"})
      : super(key: key);

  @override
  State<ViewAllAmbulancesUser> createState() => _ViewAllAmbulancesUserState();
}

class _ViewAllAmbulancesUserState extends State<ViewAllAmbulancesUser> {
  @override
  void initState() {
    print(widget.cat);
    super.initState();
  }

  AmbulanceService _ambulanceService = AmbulanceService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: AppText(
          data: "All Ambulances ",
          color: Colors.white,
          size: 20,
          fw: FontWeight.bold,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: _ambulanceService.GetAllActiveAmbulance(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<AmbulanceModel> ambulances =
                    snapshot.data as List<AmbulanceModel>;

                return ListView.builder(
                    itemCount: ambulances.length,
                    itemBuilder: (context, index) {
                      var ambulance = ambulances[index];
                      return Padding(
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 20),
                        child: CustomContainer(
                          ontap: () {},
                          height: 150,
                          width: 220,
                          decoration: BoxDecoration(
                              color: AppColors().textColor2,
                              borderRadius: BorderRadius.circular(10)),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: AppText(
                                        data: widget.type == "message"
                                            ? "Send Message"
                                            : "Book Now",
                                        color: Colors.white,
                                      )),
                                      IconButton(
                                          onPressed: () {
                                            widget.cat == "ip"
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BookAmbulanceIP(
                                                              category: widget.cat,
                                                              ampid: ambulance.ampid,
                                                              drivername: ambulance.driverName,
                                                              driverPhone: ambulance.driverPhone,
                                                              location: ambulance.location,
                                                              hid: ambulance.ownerid,
                                                            )))
                                                : sendMessage(
                                                    ambulance.ampid,
                                                    ambulance.driverName,
                                                    ambulance.driverPhone,
                                                    ambulance.location,
                                                    widget.cat,
                                                    ambulance.ownerid,
                                                  );
                                          },
                                          icon: FaIcon(
                                            FontAwesomeIcons.message,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: 20,
                                  top: 0,
                                  bottom: 50,
                                  child: Center(
                                      child: FaIcon(
                                    FontAwesomeIcons.truckMedical,
                                    color: Colors.white,
                                  ))),
                              Positioned(
                                  top: 25,
                                  left: 60,
                                  right: 10,
                                  child: AppText(
                                    data: "No: ${ambulance.ampRegNo}",
                                    color: Colors.white,
                                  )),
                              Positioned(
                                  top: 45,
                                  left: 60,
                                  right: 10,
                                  child: AppText(
                                    data: "Type: ${ambulance.category}",
                                    color: Colors.white,
                                  )),
                              Positioned(
                                  bottom: 30,
                                  right: 20,
                                  child: InkWell(
                                    onTap: () {
                                      _makePhoneCall(ambulance.driverPhone!);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.amber,
                                      child: FaIcon(
                                        FontAwesomeIcons.phone,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                              Positioned(
                                  bottom: 30,
                                  left: 20,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SendFeedback(
                                                    ampid: ambulance.ampid,
                                                  )));
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.amber,
                                      child: FaIcon(
                                        FontAwesomeIcons.envelope,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: CustomContainer(
                                    decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.8),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10))),
                                    height: 30,
                                    width: 120,
                                    ontap: () {},
                                    child: Center(
                                        child: AppText(
                                      data: ambulance.type!.toUpperCase(),
                                    )),
                                  ))
                            ],
                          ),
                        ),
                      );
                    });
              }

              return Center(
                child: Text("No data"),
              );
            }),
      ),
    );
  }

  sendMessage(String? ampid, String? driverName, String? driverPhone,
      GeoPoint? location, String? type, String? hid) {
    print(ampid);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BookAmbulance(
                  hid: hid,
                  cat: type,
                  ampid: ampid,
                  drivername: driverName,
                  location: location,
                  driverPhone: driverPhone,
                )));
  }

  track() {
    print("Track");
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }
}
