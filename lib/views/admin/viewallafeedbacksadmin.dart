import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../../models/feedbackmodel.dart';
import '../../services/feedbackservice.dart';
import '../../components/apptext.dart';
import '../../components/customcontainer.dart';
class ViewAllFeedbacksAdmin extends StatefulWidget {
  String?userid;

  ViewAllFeedbacksAdmin({Key? key,this.userid }) : super(key: key);


  @override
  State<ViewAllFeedbacksAdmin> createState() => _ViewAllFeedbacksAdminState();
}

class _ViewAllFeedbacksAdminState extends State<ViewAllFeedbacksAdmin> {
  FeedbackService _feedbackService=FeedbackService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: AppText(
          data: "All Feedbacks",
          color: Colors.white,
          fw: FontWeight.bold,
          size: 20,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: _feedbackService.getallFeedbacks(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<FeedbackModel> message=
                snapshot.data as List<FeedbackModel>;

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
                          height: 180,
                          width: 220,
                          decoration: BoxDecoration(
                              color: AppColors().textColor2,
                              borderRadius: BorderRadius.circular(10)),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: msg.replystatus==0?AppColors().primaryColor:Colors.green,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),

                                  child: msg.replystatus==0?Center(child: AppText(data: "Reply Pending",color: Colors.white,)):
                                  Center(child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AppText(data: "Reply: ${msg.reply}",color: Colors.white,),
                                  ))
                                  ,

                                ),
                              ),

                              Positioned(
                                  top: 40,
                                  left: 20,
                                  right: 10,
                                  child: AppText(
                                    size: 16,
                                    fw: FontWeight.bold,
                                    data: "${msg.title}",
                                    color: Colors.white,
                                  )),
                              Positioned(
                                  top: 70,
                                  left: 20,
                                  right: 10,
                                  child: AppText(
                                    data: "${msg.message}",
                                    color: Colors.white,
                                  )),

                              // Align(
                              //   alignment: Alignment.topRight,
                              //   child: Container(
                              //     height: 40,
                              //     width: 130,
                              //     decoration: BoxDecoration(
                              //         color: AppColors().primaryColor,
                              //         borderRadius: BorderRadius.only(
                              //             bottomLeft: Radius.circular(10),
                              //             bottomRight: Radius.circular(10))),
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         Center(
                              //             child: AppText(
                              //               data: msg.status == 1
                              //                   ? "Delete"
                              //                   : "Deleted",
                              //               color: Colors.white,
                              //             )),
                              //         msg.status == 1
                              //             ? IconButton(
                              //             onPressed: (){
                              //
                              //
                              //               _feedbackService.deleteFeedback(msg.msgid);
                              //               setState(() {
                              //
                              //               });
                              //
                              //
                              //             },
                              //             icon: FaIcon(
                              //               FontAwesomeIcons.trash,
                              //               color: Colors.white,
                              //             ))
                              //             : SizedBox()
                              //       ],
                              //     ),
                              //   ),
                              // ),

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

