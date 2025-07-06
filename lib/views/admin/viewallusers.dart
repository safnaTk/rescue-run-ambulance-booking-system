import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../../models/usermodel.dart';
import '../../services/userservice.dart';
import '../../components/apptext.dart';
import '../../components/customcontainer.dart';
import '../hospital/sendmessages.dart';
class ViewAllUsers extends StatefulWidget {
  ViewAllUsers({Key? key, }) : super(key: key);


  @override
  State<ViewAllUsers> createState() => _ViewAllUsersState();
}

class _ViewAllUsersState extends State<ViewAllUsers> {
  UserService _userService=UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: AppText(
          data: "All Users",
          color: Colors.white,
          fw: FontWeight.bold,
          size: 20,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: _userService.GetAllUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<UserModel> users =
                snapshot.data as List<UserModel>;

                return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      var user = users[index];
                      return Padding(
                        padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 20),
                        child: CustomContainer(
                          ontap: () {},
                          height: 120,
                          width: 220,
                          decoration: BoxDecoration(
                              color: AppColors().textColor2,
                              borderRadius: BorderRadius.circular(10)),
                          child: Stack(
                            children: [

                              Positioned(
                                  left: 20,
                                  top: 30,
                                  bottom: 50,
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
                                    data: "Name: ${user.name}",
                                    color: Colors.white,
                                  )),
                              Positioned(
                                  top: 45,
                                  left: 60,
                                  right: 10,
                                  child: AppText(
                                    data: "Email: ${user.email}",
                                    color: Colors.white,
                                  )),
                              Positioned(
                                  top: 65,
                                  left: 60,
                                  right: 10,
                                  child: AppText(
                                    data: "Phone: ${user.phone}",
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
