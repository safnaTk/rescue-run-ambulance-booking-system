import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constant/colors.dart';
import '../../models/bookingmodel.dart';
import '../../services/ambulanceservice.dart';
import '../../components/apptext.dart';
import '../../components/customcontainer.dart';
import '../hospital/sendmessages.dart';
import '../hospital/trackambulances.dart';
class BookingHistory extends StatefulWidget {
  String? id;
  BookingHistory({Key? key, this.id}) : super(key: key);

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
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
            future: _ambulanceService.getAllBooking(widget.id),
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
                              borderRadius: BorderRadius.circular(10)
                          ),
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
                                  child: booking.category=='ip'?AppText(
                                    data: "Name: ${booking.cause}",
                                    color: Colors.white,
                                  ):AppText(
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
                                      SizedBox(width: 20,),
                                      booking.bookingstatus == 1?IconButton(

                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TrackAmbulance(ampid: booking.reciverId,)));
                                          },
                                          icon: FaIcon( FontAwesomeIcons.locationArrow,color: Colors.amber,)):SizedBox()
                                    ],
                                  ),
                                ),
                              ),
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
  sendMessage(String?ampid) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SendMessage(ampid: ampid,)));
  }

  track() {
    print("Track");
  }
}
