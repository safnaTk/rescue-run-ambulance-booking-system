import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constant/colors.dart';
import '../../models/bookingmodel.dart';
import '../../services/ambulanceservice.dart';
import '../../components/apptext.dart';
import '../../components/customcontainer.dart';
import '../hospital/sendmessages.dart';
class ViewAllBookingAdmin extends StatefulWidget {
  String? id;
  ViewAllBookingAdmin({Key? key, this.id}) : super(key: key);

  @override
  State<ViewAllBookingAdmin> createState() => _ViewAllBookingAdminState();
}

class _ViewAllBookingAdminState extends State<ViewAllBookingAdmin> {
  AmbulanceService _ambulanceService = AmbulanceService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: AppText(
          data: "All Booking",
          size:20,
          fw: FontWeight.bold,
          color: Colors.white,

        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: _ambulanceService.getAllBookingadmin(),
            builder: (context, snapshot) {
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
                                    data: "Cause: ${booking.cause}",
                                    color: Colors.white,
                                  )),
                              Positioned(
                                  top: 45,
                                  left: 60,
                                  right: 10,
                                  child: AppText(
                                    data: "Casualities: ${booking.casualities}",
                                    color: Colors.white,
                                  )),
                              Positioned(
                                  top: 65,
                                  left: 60,
                                  right: 10,
                                  child: AppText(
                                    data: "Location: ${booking.location}",
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
                              // booking.bookingstatus == 0
                              //     ? Positioned(
                              //     top: 26,
                              //     right: 10,
                              //     child: Container(
                              //       width: 110,
                              //       child: Row(
                              //         children: [
                              //           AppText(
                              //             data: "Accept",
                              //             color: Colors.white,
                              //           ),
                              //           SizedBox(width: 10,),
                              //           Container(
                              //             height: 45,
                              //             width: 45,
                              //             decoration: BoxDecoration(
                              //                 shape: BoxShape.circle,
                              //                 color: Colors.green),
                              //             child: Center(
                              //               child: InkWell(
                              //                   onTap: (){
                              //
                              //                     BookingModel bookings=BookingModel(bookingid: booking.bookingid);
                              //                     _ambulanceService.acceptBooking(bookings);
                              //
                              //                     AmbulanceModel ambulance=AmbulanceModel(ampid: booking.reciverId);
                              //                     _ambulanceService.updateAvailability(ambulance);
                              //
                              //                     FirebaseFirestore.instance.collection('track').doc(booking.reciverId).set({
                              //
                              //                       'tid':booking.reciverId,
                              //
                              //                       'bookingid':booking.bookingid,
                              //                       'status':1,
                              //                       'track':"accepted"
                              //                     });
                              //
                              //                     setState(() {
                              //
                              //                     });
                              //                   },
                              //                   child: FaIcon(FontAwesomeIcons.check)),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ))
                              //     : SizedBox(),
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
}
