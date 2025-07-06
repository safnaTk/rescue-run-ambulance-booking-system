import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../constant/colors.dart';
import '../../models/feedbackmodel.dart';
import '../../services/feedbackservice.dart';
import '../../components/appbutton.dart';
import '../../components/apptext.dart';
import '../../components/customcontainer.dart';
import '../../components/customtextformfield.dart';

class ViewAllFeedbackAmbulance extends StatefulWidget {
  String?ampid;
  String?title;
  String?location;
  String?owner;
  String?ownerid;

  ViewAllFeedbackAmbulance({Key? key,this.ampid,this.location,this.title,this.owner,this.ownerid }) : super(key: key);

  @override
  State<ViewAllFeedbackAmbulance> createState() => _ViewAllFeedbackAmbulanceState();
}

class _ViewAllFeedbackAmbulanceState extends State<ViewAllFeedbackAmbulance> {

  FeedbackService _feedbackService=FeedbackService();
  TextEditingController _replyController = TextEditingController();

  //..............End of  TextEditing Controllers......................

  //----------Form key........................
  final _replyKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor:Colors.teal,
        title: AppText(
          data:"All Feedbacks",
          color: Colors.white,
          fw: FontWeight.bold,
          size: 20,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: _feedbackService.getFeedbyambulance(widget.ampid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<FeedbackModel> message=
                snapshot.data as List<FeedbackModel>;

                if(message.length>0){
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
                            height: 190,
                            width: 220,
                            decoration: BoxDecoration(
                                color: Colors.teal,
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

                                    child: msg.replystatus==0?Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Center(child: AppText(data: "Reply Pending",color: Colors.white,)),
                                        SizedBox(width: 20,),
                                        IconButton(onPressed: (){

                                          showDialog(context: context, builder: (context){

                                            return AlertDialog(
                                              title: AppText(data: "Feedback Reply",color: Colors.blue.shade900,),
                                              backgroundColor:Colors.white,
                                              content: Container(
                                                height: 180,
                                                width: MediaQuery.of(context).size.width,
                                                color: Colors.transparent,
                                                child: Form(
                                                  key: _replyKey,
                                                  child: Column(
                                                    children: [

                                                      CustomTextFormField(
                                                        style: TextStyle(color: Colors.teal.shade900),
                                                        maxlines: 3,
                                                        controller: _replyController,
                                                        hintText: 'Enter a Reply',
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Please enter a Reply';
                                                          }
                                                          return null;
                                                        },
                                                        enabledBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.grey),
                                                        ),
                                                        focusedBorder: const UnderlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.blue),
                                                        ),

                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      Center(
                                                        child: AppButton(
                                                          onTap: () {
                                                            if (_replyKey.currentState!.validate()) {
                                                              FeedbackModel _message=FeedbackModel(
                                                                  msgid: msg.msgid,
                                                                  reply: _replyController.text
                                                              );
                                                              _feedbackService.updateFeedback(_message).then((value) => Navigator.pop(context));

                                                            }
                                                          },

                                                          fontColor: Colors.black,
                                                          height: 45,
                                                          color: Colors.teal.shade900,
                                                          text: "Reply",
                                                          width: 250,
                                                        ),
                                                      )



                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });




                                        }, icon: FaIcon(FontAwesomeIcons.message,color: Colors.white,))
                                      ],
                                    ):
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



                              ],
                            ),
                          ),
                        );
                      });
                }else  return Center(
                  child: Lottie.asset('assets/json/empty.json'),
                );

              }

              return Center(
                child: Lottie.asset('assets/json/empty.json'),
              );
            }),
      ),
    );
  }


}
