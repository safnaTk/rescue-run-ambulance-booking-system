import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rescuerun/common/Login_page.dart';
import 'package:rescuerun/views/admin/viewallambulaceAdmin.dart';
import 'package:rescuerun/components/apptext.dart';
import 'package:rescuerun/views/admin/viewallafeedbacksadmin.dart';
import 'package:rescuerun/views/admin/viewallbookingadmin.dart';
import 'package:rescuerun/views/admin/viewallhospitals.dart';
import 'package:rescuerun/views/admin/viewallnotification.dart';
import 'package:rescuerun/views/admin/viewallusers.dart';
import 'package:rescuerun/views/ambulance/sendnotification.dart';
import 'package:rescuerun/views/hospital/viewallambulances.dart';
import 'package:rescuerun/views/users/viewallambulanceuser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'hospitalregistration.dart';

class AdminHomePage extends StatefulWidget {
  final Map?snap;
  final String?name;
  final String?email;
  final String?phone;
  const AdminHomePage(
      {Key? key, this.snap, this.name, this.email, this.phone})
      : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  String? _name;
  String? _email;
  String? _phone;
  String? token;
  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    token = await _pref.getString('token');
    _name = await _pref.getString('name',);
    _email = await _pref.getString('email',);
    _phone = await _pref.getString('phone',);

    setState(() {});
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Welcome ! ${_name.toString()}",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
        actions: [
          IconButton(onPressed: () async {
            SharedPreferences _pref = await SharedPreferences.getInstance();
            _pref.clear();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
          }, icon: FaIcon(FontAwesomeIcons.arrowRightFromBracket,color: Colors.yellowAccent))
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20,right: 20,left: 20),
        color: Colors.green.shade100,
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 90,
                width: 300,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.teal,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HospitalRegistrations()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.hospital,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          AppText(
                            data: "Add Hospitals",
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 90,
                width: 300,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.teal,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewAllHospitals()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.hospital,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          AppText(
                            data: "View Hospitals",
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 90,
                width: 300,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.teal,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewAllAmbulancesAdmin()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.truckMedical,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          AppText(
                            data: "View Ambulances",
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 90,
                width: 300,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.teal,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewAllBookingAdmin()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.bookBookmark,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          AppText(
                            data: "View Bookings",
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 90,
                width: 300,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.teal,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewAllUsers()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.user,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          AppText(
                            data: "View Users",
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 90,
                width: 300,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.teal,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SendNotification()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.bell,
                            color: Colors.white
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          AppText(
                            data: "Send Notifications",
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 90,
                width: 300,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.teal,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewAllNotification()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.bell,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          AppText(
                            data: "View Notifications",
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 90,
                width: 300,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.teal,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewAllFeedbacksAdmin()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.comments,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          AppText(
                            data: "View Feedbacks",
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),



            ],
          ),
        ),

      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:rescuerun/screens/admin/viewallafeedbacksadmin.dart';
// import 'package:rescuerun/screens/admin/viewallbookingadmin.dart';
// import 'package:rescuerun/screens/admin/viewallhospitals.dart';
// import 'package:rescuerun/screens/admin/viewallnotification.dart';
// import 'package:rescuerun/screens/admin/viewallusers.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../common/Login_page.dart';
// import '../../constant/colors.dart';
// import '../../utilities/apptext.dart';
// import '../../utilities/customcontainer.dart';
// import '../ambulance/sendnotification.dart';
// import '../hospital/viewallambulances.dart';
// import 'hospitalregistration.dart';
//
//
//
// class AdminHomePage extends StatefulWidget {
//   const AdminHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<AdminHomePage> createState() => _AdminHomePageState();
// }
//
// class _AdminHomePageState extends State<AdminHomePage> {
//   String? _name;
//   String? _email;
//   String? _phone;
//   String? token;
//   getData() async {
//     SharedPreferences _pref = await SharedPreferences.getInstance();
//
//     token = await _pref.getString('token');
//     _name = await _pref.getString(
//       'name',
//     );
//     _email = await _pref.getString(
//       'email',
//     );
//     _phone = await _pref.getString(
//       'phone',
//     );
//
//     setState(() {});
//   }
//
//   @override
//   void initState() {
//     getData();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(onPressed: ()async{
//             SharedPreferences _pref = await SharedPreferences.getInstance();
//             _pref.clear();
//             Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => LoginPage()),
//                     (route) => false);
//
//
//
//           }, icon: FaIcon(FontAwesomeIcons.arrowRightFromBracket))
//         ],
//         backgroundColor: AppColors().primaryColor,
//         title: AppText(
//           data: "Welcome ! ${_name.toString()}",
//         ),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         height: double.infinity,
//         width: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomContainer(
//                     ontap: (){
//
//
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>HospitalRegistrations()));
//                     },
//                     height: 70,
//                     width: 150,
//                     decoration: BoxDecoration(
//                         color: AppColors().primaryColor
//
//                     ),
//                     child: Center(child: AppText(data: "Add Hospitals",color: Colors.white,),),
//                   ),
//                 ),
//                 SizedBox(width: 10,),
//                 Expanded(
//                   child: CustomContainer(
//                     ontap: (){
//
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllHospitals()));
//                     },
//                     height: 70,
//                     width: 150,
//                     decoration: BoxDecoration(
//                         color: AppColors().primaryColor
//
//                     ),
//                     child: Center(child: AppText(data: "View Hospitals",color: Colors.white,),),
//                   ),
//                 ),
//
//               ],
//             ),
//             SizedBox(height: 20,),
//             Row(
//               children: [
//
//                 Expanded(
//                   child: CustomContainer(
//                     ontap: (){
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllAmbulances()));
//                     },
//                     height: 70,
//                     width: 150,
//                     decoration: BoxDecoration(
//                         color: AppColors().primaryColor
//
//                     ),
//                     child: Center(child: AppText(data: "View Ambulances",color: Colors.white,),),
//                   ),
//                 ),
//
//               ],
//             ),
//             SizedBox(height: 20,),
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomContainer(
//                     ontap: (){
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllBookingAdmin()));
//
//                     },
//                     height: 70,
//                     width: 150,
//                     decoration: BoxDecoration(
//                         color: AppColors().primaryColor
//
//                     ),
//                     child: Center(child: AppText(data: "View Bookings",color: Colors.white,),),
//                   ),
//                 ),
//                 SizedBox(width: 10,),
//                 Expanded(
//                   child: CustomContainer(
//                     ontap: (){
//
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllUsers()));
//                     },
//                     height: 70,
//                     width: 150,
//                     decoration: BoxDecoration(
//                         color: AppColors().primaryColor
//
//                     ),
//                     child: Center(child: AppText(data: "View Users",color: Colors.white,),),
//                   ),
//                 ),
//
//               ],
//             ),
//
//             SizedBox(height: 20,),
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomContainer(
//                     ontap: (){
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>SendNotification()));
//                     },
//                     height: 70,
//                     width: 150,
//                     decoration: BoxDecoration(
//                         color: AppColors().primaryColor
//
//                     ),
//                     child: Center(child: AppText(data: "Send Notifications",color: Colors.white,),),
//                   ),
//                 ),
//                 SizedBox(width: 10,),
//                 Expanded(
//                   child: CustomContainer(
//                     ontap: (){
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllNotification()));
//                     },
//                     height: 70,
//                     width: 150,
//                     decoration: BoxDecoration(
//                         color: AppColors().primaryColor
//
//                     ),
//                     child: Center(child: AppText(data: "View Notifications",color: Colors.white,),),
//                   ),
//                 ),
//
//               ],
//             ),
//
//             SizedBox(height: 20,),
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomContainer(
//                     ontap: (){
//
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllFeedbacksAdmin()));
//                     },
//                     height: 70,
//                     width: 150,
//                     decoration: BoxDecoration(
//                         color: AppColors().primaryColor
//
//                     ),
//                     child: Center(child: AppText(data: "View Feedbacks",color: Colors.white,),),
//                   ),
//                 ),
//                 // SizedBox(width: 10,),
//                 // Expanded(
//                 //   child: CustomContainer(
//                 //     ontap: (){},
//                 //     height: 70,
//                 //     width: 150,
//                 //     decoration: BoxDecoration(
//                 //         color: AppColors().primaryColor
//                 //
//                 //     ),
//                 //     child: Center(child: AppText(data: "View Complaints",color: Colors.white,),),
//                 //   ),
//                 // ),
//
//               ],
//             ),
//
//
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }
