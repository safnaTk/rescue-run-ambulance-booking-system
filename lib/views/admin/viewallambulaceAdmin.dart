
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rescuerun/views/hospital/sendmessages.dart';
import 'package:rescuerun/views/hospital/trackambulances.dart';
import 'package:rescuerun/views/hospital/viewallfeedbackambulance.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/ambulancemodel.dart';
import '../../services/ambulanceservice.dart';
import '../../components/apptext.dart';
import '../../components/customcontainer.dart';
class ViewAllAmbulancesAdmin extends StatefulWidget {
  String?hid;
  String?type;
  ViewAllAmbulancesAdmin({Key? key, this.type,this.hid}) : super(key: key);

  @override
  State<ViewAllAmbulancesAdmin> createState() => _ViewAllAmbulancesAdminState();
}

class _ViewAllAmbulancesAdminState extends State<ViewAllAmbulancesAdmin> {
  AmbulanceService _ambulanceService = AmbulanceService();
  @override
  Widget build(BuildContext context) {
    print(widget.hid.toString());
    return Scaffold(
        backgroundColor: Colors.green.shade100,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: AppText(
            data: "All Ambulances",
            color: Colors.white,
            fw: FontWeight.bold,
            size: 20,
          ),
        ),
        body: SafeArea(
          child: FutureBuilder(

            // changed
              future: _ambulanceService.GetAllAmbulance(),
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
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(10)),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    decoration: BoxDecoration(
                                        color: Colors.red.shade900,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10))),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Center(
                                              child: AppText(
                                                data: widget.type == "message"
                                                    ? "Send Message"
                                                    : widget.type == null
                                                    ? ""
                                                    : "Track",
                                                color: Colors.white,
                                              )),
                                          widget.type == "message"
                                              ? IconButton(
                                              onPressed: () {
                                                sendMessage(ambulance.ampid);
                                              },
                                              icon: FaIcon(
                                                FontAwesomeIcons.message,
                                                color: Colors.white,
                                              )) :
                                          widget.type == null ? SizedBox() :
                                          IconButton(
                                              onPressed: ambulance
                                                  .avilableStatus == 0 ? () {
                                                {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              TrackAmbulance(
                                                                ampid: ambulance
                                                                    .ampid,)));
                                                }
                                              }
                                                  : () {
                                                {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                      backgroundColor: Colors
                                                          .red,
                                                      duration: Duration(
                                                          seconds: 3),
                                                      content: Container(
                                                          height: 85,
                                                          child: Center(
                                                              child: Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                      backgroundColor: Colors
                                                                          .amber,
                                                                      child: Icon(
                                                                        Icons
                                                                            .warning,
                                                                        color: Colors
                                                                            .white,
                                                                      )),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Expanded(
                                                                      child: Text(
                                                                          "No Tracking data availabe")),
                                                                ],
                                                              )))));
                                                }
                                              },
                                              icon: FaIcon(
                                                FontAwesomeIcons.locationArrow,
                                                color: Colors.white,
                                              ))
                                        ]
                                    ),
                                  ),
                                ),
                                Positioned(
                                    left: 20,
                                    top: 0,
                                    bottom: 50,
                                    child: Center(
                                        child: FaIcon(
                                          FontAwesomeIcons.triangleExclamation,
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
                                // Positioned(
                                //     // top: 40,
                                //     // right: 10,
                                //     // bottom: 50,
                                //   top:110,
                                //     bottom:40,
                                //     right: 20,
                                //
                                //     child: FaIcon(
                                //       FontAwesomeIcons.phone,
                                //       color: Colors.green,
                                //     )),
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
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewAllFeedbackAmbulance(
                                                      ampid: ambulance
                                                          .ampid,)));
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.amber,
                                        child: FaIcon(
                                          FontAwesomeIcons.envelope,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        );
                      });
                }

                return Center(
                  child: Text("no data"),
                );
              }),
        )
    );
  }
  sendMessage(String?ampid) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SendMessage(ampid: ampid,)));
  }

  track() {
    print("Track");
  }

  notrack(){

    print("no track");
  }
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }
}
