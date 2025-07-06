
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constant/colors.dart';
import '../../models/messagemodel.dart';
import '../../services/ambulanceservice.dart';
import '../../components/apptext.dart';
import '../../components/customcontainer.dart';

class ViewAllMessagesHospital extends StatefulWidget {
  String?hid;

  ViewAllMessagesHospital({Key? key,this.hid, required ampid }) : super(key: key);

  @override
  State<ViewAllMessagesHospital> createState() => _ViewAllMessagesHospitalState();
}

class _ViewAllMessagesHospitalState extends State<ViewAllMessagesHospital> {

  AmbulanceService _ambulanceService=AmbulanceService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: AppColors().primaryColor,
        title: AppText(
          data: "All Messages",
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: _ambulanceService.getallMessages(widget.hid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<MessageModel> message=
                snapshot.data as List<MessageModel>;

                return ListView.builder(
                    itemCount: message.length,
                    itemBuilder: (context, index) {
                      var msg = message[index];
                      print(msg.title);
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
                                      color: AppColors().primaryColor,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: AppText(
                                            data: msg.status == 1
                                                ? "Delete"
                                                : "Deleted",
                                            color: Colors.white,
                                          )),
                                      msg.status == 1
                                          ? IconButton(
                                          onPressed: (){


                                            _ambulanceService.deleteMessage(msg.msgid);
                                            setState(() {

                                            });


                                          },
                                          icon: FaIcon(
                                            FontAwesomeIcons.trash,
                                            color: Colors.white,
                                          ))
                                          : SizedBox()
                                    ],
                                  ),
                                ),
                              ),

                              Positioned(
                                  top: 25,
                                  left: 60,
                                  right: 10,
                                  child: AppText(
                                    size: 16,
                                    fw: FontWeight.bold,
                                    data: "${msg.title}",
                                    color: Colors.white,
                                  )),
                              Positioned(
                                  top: 45,
                                  left: 60,
                                  right: 10,
                                  child: AppText(
                                    data: "${msg.message}",
                                    color: Colors.white,
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
      ),
    );
  }


}
