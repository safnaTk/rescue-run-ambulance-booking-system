import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rescuerun/components/appbutton.dart';

import '../../constant/colors.dart';
import '../../models/messagemodel.dart';
import '../../services/ambulanceservice.dart';
import '../../components/apptext.dart';
import '../../components/customcontainer.dart';
import '../../components/customtextformfield.dart';

class ViewAllMessagesAmbulance extends StatefulWidget {
  String? ampid;

  ViewAllMessagesAmbulance({
    Key? key,
    this.ampid,
  }) : super(key: key);

  @override
  State<ViewAllMessagesAmbulance> createState() =>
      _ViewAllMessagesAmbulanceState();
}

class _ViewAllMessagesAmbulanceState extends State<ViewAllMessagesAmbulance> {
  AmbulanceService _ambulanceService = AmbulanceService();
 final _replyKey=GlobalKey<FormState>();
 TextEditingController _replyController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor:Colors.teal,
        title: AppText(
          data: "All Messages",
          color: Colors.white,
          fw: FontWeight.bold,
          size: 20,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: _ambulanceService.getallMessagesAmbulance(widget.ampid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<MessageModel> message =
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
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          height: 60,
                                          width: MediaQuery.of(context).size.width-20,
                                          decoration: BoxDecoration(
                                              color: msg.replystatus==0?AppColors().primaryColor:Colors.green,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10))),

                                          child: msg.replystatus==0?Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,


                                            children: [
                                              Center(child: AppText(data: "Reply Pending",color: Colors.white,)),
                                              SizedBox(width: 5,),

                                              Expanded(
                                                child: IconButton(onPressed: (){

                                                  showDialog(context: context, builder: (context){

                                                    return AlertDialog(
                                                      title: AppText(
                                                        data: "Message Reply",
                                                        color: Colors.blue.shade900,
                                                        fw: FontWeight.bold,),
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
                                                                   MessageModel _message=MessageModel(
                                                                          msgid: msg.msgid,
                                                                          reply: _replyController.text
                                                                      );
                                                                      _ambulanceService.updateMessage(_message).then((value) => Navigator.pop(context));

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




                                                }, icon: FaIcon(FontAwesomeIcons.message,color: Colors.white,)),
                                              )
                                            ],
                                          ):
                                          Center(child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: AppText(data: "Reply: ${msg.reply}",color: Colors.white,),
                                          ))
                                          ,

                                        ),
                                      ),
                                      // Center(
                                      //     child: AppText(
                                      //   data: msg.status == 1
                                      //       ? "Delete"
                                      //       : "Deleted",
                                      //   color: Colors.white,
                                      // )),

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
