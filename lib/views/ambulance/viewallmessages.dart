import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constant/colors.dart';
import '../../models/messagemodel.dart';
import '../../services/ambulanceservice.dart';
import '../../components/apptext.dart';
import '../../components/customcontainer.dart';
class ViewAllMessagesAmbulance extends StatefulWidget {
  String?ampid;
  String?hid;
  ViewAllMessagesAmbulance({Key? key,this.ampid,this.hid }) : super(key: key);
  @override
  State<ViewAllMessagesAmbulance> createState() => _ViewAllMessagesAmbulanceState();
}

class _ViewAllMessagesAmbulanceState extends State<ViewAllMessagesAmbulance> {
  AmbulanceService _ambulanceService=AmbulanceService();
  @override
  Widget build(BuildContext context) {
    print(widget.hid);
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: AppText(
          data: "All Messages",
          color: Colors.white,
          fw: FontWeight.bold,
          size:20,
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
                                  height:40,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: AppColors().primaryColor,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                  child:  msg.replystatus == 1 ?Center(child: AppText(data: msg.reply,color: Colors.white,)):Center(child: AppText(data: "Reply Pending",color: Colors.white,)),

                                ),
                              ),

                              Positioned(
                                  top: 40,
                                  left: 60,
                                  right: 10,
                                  child: AppText(
                                    size: 16,
                                    fw: FontWeight.bold,
                                    data: "${msg.title}",
                                    color: Colors.white,
                                  )),
                              Positioned(
                                  top: 70,
                                  left: 60,
                                  right: 10,
                                  child: AppText(
                                    data: "${msg.message}",
                                    color: Colors.white,
                                  )),
                              msg.status == 1
                                  ? Positioned(
                                top:20,
                                    right: 20,
                                    child: IconButton(
                                    onPressed: () {
                                      _ambulanceService
                                          .deleteMessage(msg.msgid);
                                      setState(() {});
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.trash,
                                      color: Colors.white,
                                    )),
                                  )
                                  : SizedBox()

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
