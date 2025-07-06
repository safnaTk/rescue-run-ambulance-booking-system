import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/colors.dart';
import '../../models/ambulancemodel.dart';
import '../../models/bookingmodel.dart';
import '../../services/ambulanceservice.dart';
import '../../components/apptext.dart';
import '../../components/customcontainer.dart';
import '../hospital/sendmessages.dart';
class ViewAllIpBookingAmbulance extends StatefulWidget {
  String? id;
  ViewAllIpBookingAmbulance({Key? key, this.id}) : super(key: key);
  @override
  State<ViewAllIpBookingAmbulance> createState() => _ViewAllIpBookingAmbulanceState();
}

class _ViewAllIpBookingAmbulanceState extends State<ViewAllIpBookingAmbulance> {
  AmbulanceService _ambulanceService = AmbulanceService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: AppText(
          data: "My Booking",
          color: Colors.white,
          fw: FontWeight.bold,
          size: 20,
      ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: _ambulanceService.getAllBookingAmbulanceIP(widget.id),

            builder: (context, snapshot) {
              if(snapshot.hasData && snapshot.data!.length==0){
                return Center(
                  child: Text("No Bookings"),
                );
              }
              if (snapshot.hasData) {
                List<BookingModel> bookings =
                snapshot.data as List<BookingModel>;

                return ListView.builder(
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      var booking = bookings[index];
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
                                    data: "Patient: ${booking.cause}",
                                    color: Colors.white,
                                  )),
                              Positioned(
                                  top: 45,
                                  left: 60,
                                  right: 10,
                                  child: AppText(
                                    data: "Date: ${booking.casualities}",
                                    color: Colors.white,
                                  )),
                              Positioned(
                                  top: 65,
                                  left: 60,
                                  right: 10,
                                  child: AppText(
                                    data: "Destination: ${booking.location}",
                                    color: Colors.white,
                                  )),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: AppColors().primaryColor,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: AppText(
                                            data: booking.bookingstatus == 0
                                                ? "Pending"
                                                : "Confirmed",
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              booking.bookingstatus == 0
                                  ? Positioned(
                                  top: 26,
                                  right: 10,
                                  child: Container(
                                    width: 110,
                                    child: Row(
                                      children: [
                                        AppText(
                                          data: "Accept",
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 10,),
                                        Container(
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.green),
                                          child: Center(
                                            child: InkWell(
                                                onTap: (){

                                                  BookingModel bookings=BookingModel(bookingid: booking.bookingid);
                                                  _ambulanceService.acceptBooking(bookings);

                                                  AmbulanceModel ambulance=AmbulanceModel(ampid: booking.reciverId);
                                                  _ambulanceService.updateAvailability(ambulance);


                                                  FirebaseFirestore.instance.collection('track').doc(booking.reciverId).set({

                                                    'tid':booking.reciverId,

                                                    'bookingid':booking.bookingid,
                                                    'status':1,
                                                    'track':"accepted"
                                                  });

                                                  setState(() {

                                                  });
                                                },
                                                child: FaIcon(FontAwesomeIcons.check)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                                  : SizedBox(),

                              Positioned(
                                bottom: 26,
                                right: 18,
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green),
                                  child: Center(
                                    child: InkWell(
                                        onTap: (){

                                          _makePhoneCall(booking.senderPhone.toString());
                                        },
                                        child: FaIcon(FontAwesomeIcons.phone)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }

              // return Center(
              //   child: Text("no data"),
              // );
              return Center(
                  child:CircularProgressIndicator()
              );
            }),
      ),
    );
  }
  sendMessage(String? ampid) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SendMessage(
              ampid: ampid,
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
