import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rescuerun/components/customcontainer.dart';

import '../../constant/colors.dart';
import '../../models/notificationmodel.dart';
import '../../services/notificationservice.dart';
import '../../components/apptext.dart';
class ViewAllNotification extends StatefulWidget {
  ViewAllNotification({Key? key, }) : super(key: key);

  @override
  State<ViewAllNotification> createState() => _ViewAllNotificationState();
}

class _ViewAllNotificationState extends State<ViewAllNotification> {
  NotificationService _notificationService=NotificationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: AppText(
          data: "All Notification",
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: _notificationService.getAllNotification(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<NotificationModel> message=
                snapshot.data as List<NotificationModel>;

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


                                            _notificationService.deleteMessage(msg.msgid);
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
