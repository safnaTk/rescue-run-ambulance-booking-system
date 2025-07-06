import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../../models/notificationmodel.dart';
import '../../services/notificationservice.dart';
import '../../components/apptext.dart';
import '../../components/customcontainer.dart';
class ViewAllNotificationUser extends StatefulWidget {
  ViewAllNotificationUser({Key? key,}):super(key:key);

  @override
  State<ViewAllNotificationUser> createState() => _ViewAllNotificationUserState();
}

class _ViewAllNotificationUserState extends State<ViewAllNotificationUser> {
  NotificationService _notificationService=NotificationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: AppText(
          data: "All Notification",
          fw: FontWeight.bold,
          size: 20,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: _notificationService.getAllActiveNotification(),
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
                          height: 100,
                          width: 220,
                          decoration: BoxDecoration(
                              color: AppColors().textColor2,
                              borderRadius: BorderRadius.circular(10)),
                          child: Stack(
                            children: [
                              Positioned(
                                  left: 20,
                                  top: 40,

                                  child: Center(
                                      child:AppText(
                                        data: "${index+1}",
                                        color: Colors.white,
                                      ))),

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
