
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:lottie/lottie.dart';
// import 'package:rescuerun/common/Login_page.dart';
// import 'package:rescuerun/screens/users/usermapscreen.dart';
// import 'package:rescuerun/screens/users/viewallambulanceuser.dart';
// import 'package:rescuerun/screens/users/viewallfeedbacksuser.dart';
// import 'package:rescuerun/screens/users/viewallnotificationuser.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../components/apptext.dart';
// import '../../models/hospitalmodel.dart';
// import '../../services/hospitalservice.dart';
// import '../../services/userservice.dart';
// import 'bookinghistory.dart';
// import 'hospitaldetails.dart';
//
// class UserHomePage extends StatefulWidget {
//   const UserHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<UserHomePage> createState() => _UserHomePageState();
// }
//
// class _UserHomePageState extends State<UserHomePage> {
//   String? _name;
//   String? _email;
//   String? _phone;
//   String? token;
//   String?_id;
//
//   UserService userService = UserService();
//
//   getData() async {
//     SharedPreferences _pref = await SharedPreferences.getInstance();
//
//     token = await _pref.getString('token');
//     _name = await _pref.getString('name',);
//     _email = await _pref.getString('email',);
//     _phone = await _pref.getString('phone',);
//     _id = await _pref.getString('uid',);
//     setState(() {});
//   }
//
//   List<String>? categories = [
//     "Ambulance",
//   ];
//   List<Widget> icons = [
//     FaIcon(
//       FontAwesomeIcons.truckMedical,
//       color: Colors.white,
//     ),
//   ];
//
//   HospitalService _hospitalService = HospitalService();
//
//   @override
//   void initState() {
//     getData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print(_name.toString());
//     return Scaffold(
//         drawer: Drawer(
//           backgroundColor:Colors.teal,
//           child: ListView(
//             children: [
//               DrawerHeader(child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       CircleAvatar(
//                         child: AppText(data: '${_name![0]}',),
//                       ),
//                       SizedBox(width: 20,),
//                       AppText(data: _name.toString(),color: Colors.white,)
//                     ],
//                   )
//                 ],
//               )),
//               ListTile(
//                 title: AppText(data: "My Bookings",color: Colors.white,),
//
//                 onTap: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingHistory(
//                     // id: _id,
//                   )));
//                 },
//               ),
//               ListTile(
//                 title: AppText(data: "Feedback History",color: Colors.white,),
//
//                 onTap: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllFeedbacksUsers(
//                     // userid: _id,
//                   )));
//                 },
//               ),
//               ListTile(
//                 onTap: () {
//                   userService.logOut();
//                   Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginPage()),
//                           (route) => false);
//                 },
//                 title: AppText(data: "Logout",color: Colors.white,),
//               ),
//
//             ],
//           ),
//         ),
//         appBar: AppBar(
//           actions: [
//
//             IconButton(onPressed: (){
//
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllNotificationUser()));
//
//
//
//             }, icon: FaIcon(FontAwesomeIcons.bell,color: Colors.yellow,))
//           ],
//           backgroundColor:Colors.yellowAccent,
//           title: AppText(
//             data: "Welcome ! ${_name.toString()}",
//           ),
//         ),
//         body: CustomScrollView(
//           slivers: [
//             SliverToBoxAdapter(
//               child: Container(
//                 padding: EdgeInsets.only(left: 20, right: 20, top: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     AppText(
//                       data: "Always ready \nanytime & anywhere!",
//                       size: 28,
//                       color: Colors.blue.shade900,
//                       fw: FontWeight.bold,
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             // SliverToBoxAdapter(
//             //   child: Container(
//             //     padding: EdgeInsets.only(right: 20, left: 20, top: 30),
//             //     child: Row(
//             //       children: [
//             //         Expanded(
//             //             child: Container(
//             //           padding: EdgeInsets.only(left: 15, top: 15),
//             //           height: 48,
//             //           width: 250,
//             //           decoration: BoxDecoration(
//             //               borderRadius: BorderRadius.circular(10),
//             //               color: AppColors().secondaryColor),
//             //           child: AppText(
//             //             data: "Search.....",
//             //             color: Colors.black54,
//             //           ),
//             //         )),
//             //         SizedBox(
//             //           width: 20,
//             //         ),
//             //         FaIcon(FontAwesomeIcons.magnifyingGlass)
//             //       ],
//             //     ),
//             //   ),
//             // ),
//
//             SliverToBoxAdapter(
//               child: Container(
//                   padding: EdgeInsets.only(left: 20, right: 20, top: 20),
//                   child: AppText(
//                     data: "For IP Patients",
//                     size: 20,
//                     color: Colors.blue.shade900,
//                     fw: FontWeight.bold,
//                   )),
//             ),
//
//             SliverToBoxAdapter(
//               child: Container(
//                 margin: EdgeInsets.only(left: 20, right: 20, top: 20),
//                 height: 50,
//                 child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: categories!.length,
//                     itemBuilder: (context, index) {
//                       return InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       ViewAllAmbulanceUser(
//                                         // cat: "ip",
//                                       )));
//                         },
//                         child: Container(
//                           width: 150,
//                           decoration: BoxDecoration(
//                               color: Colors.teal,
//                               borderRadius: BorderRadius.circular(10)),
//                           margin: EdgeInsets.only(right: 10),
//                           padding: EdgeInsets.all(10),
//                           child: Center(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 icons[index],
//                                 AppText(
//                                   data: categories![index],
//                                   color: Colors.white,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: Container(
//                   padding: EdgeInsets.only(left: 20, right: 20, top: 20),
//                   child: AppText(
//                     data: "Services by Category",
//                     size: 20,
//                     color:Colors.teal,
//                     fw: FontWeight.bold,
//                   )),
//             ),
//             SliverToBoxAdapter(
//               child: Container(
//                 margin: EdgeInsets.only(left: 20, right: 20, top: 20),
//                 height: 50,
//                 child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: categories!.length,
//                     itemBuilder: (context, index) {
//                       return InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       ViewAllAmbulanceUser()));
//                         },
//                         child: Container(
//                           width: 150,
//                           decoration: BoxDecoration(
//                               color: Colors.teal,
//                               borderRadius: BorderRadius.circular(10)),
//                           margin: EdgeInsets.only(right: 10),
//                           padding: EdgeInsets.all(10),
//                           child: Center(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 icons[index],
//                                 AppText(
//                                   data: categories![index],
//                                   color: Colors.white,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: InkWell(
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => UserMapScreen()));
//                 },
//                 child: Container(
//                   height: 80,
//                   margin: EdgeInsets.only(left: 20, right: 20, top: 20),
//                   padding:
//                   EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.blueGrey.withOpacity(0.3)),
//                   child: Row(
//                     children: [
//                       Lottie.asset('assets/json/ambulance.json'),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: AppText(
//                           data: "Ambulances Near You",
//                           color:Colors.blue.shade900,
//                           size: 18,
//                         ),
//                       ),
//                       FaIcon(
//                         FontAwesomeIcons.circleArrowRight,
//                         color: Colors.blue.shade900,
//                         size: 28,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: Container(
//                   padding: EdgeInsets.only(left: 20, right: 20, top: 20),
//                   child: AppText(
//                     data: "Hospitals near you",
//                     size: 20,
//                     color: Colors.blue.shade900,
//                     fw: FontWeight.bold,
//                   )),
//             ),
//             SliverToBoxAdapter(
//               child: Container(
//                   padding:
//                   EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
//                   height: 330,
//                   width: MediaQuery.of(context).size.width,
//                   child: FutureBuilder(
//                     future: _hospitalService.GetAllHospital(),
//                     builder: (_, snapshot) {
//
//
//                       if (snapshot.hasData) {
//                         List<HospitalModel> hospitals =
//                         snapshot.data as List<HospitalModel>;
//                         return ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: hospitals.length,
//                             itemBuilder: (context, index) {
//                               var hospital = hospitals[index];
//                               return InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               HospitalDetailsPage(
//                                                 snap: hospital,
//                                               )));
//                                 },
//                                 child: Card(
//                                   child: Container(
//                                     width: 200,
//                                     color: Colors.white,
//                                     height: 330,
//                                     child: Stack(
//                                       children: [
//                                         Container(
//                                           height: 160,
//                                           width: 200,
//                                           decoration: BoxDecoration(
//                                               image: DecorationImage(
//                                                   fit: BoxFit.cover,
//                                                   image: AssetImage(
//                                                       'assets/images/hospital1.jpg'))),
//                                         ),
//                                         Positioned(
//                                             left: 45,
//                                             right: 10,
//                                             bottom: 80,
//                                             child: AppText(
//                                               data: hospital.hname,
//                                               fw: FontWeight.bold,
//                                               color: Colors.black54,
//                                               size: 15,
//                                             )),
//                                         Positioned(
//                                             left: 20,
//                                             bottom: 50,
//                                             right: 10,
//                                             child: Row(
//                                               children: [
//                                                 FaIcon(
//                                                   FontAwesomeIcons.locationPin,
//                                                   color: Colors.black
//                                                       .withOpacity(0.5),
//                                                 ),
//                                                 SizedBox(
//                                                   width: 10,
//                                                 ),
//                                                 AppText(
//                                                   data: hospital.state,
//                                                   fw: FontWeight.bold,
//                                                   color: Colors.black54,
//                                                   size: 15,
//                                                 ),
//                                               ],
//                                             )),
//                                         Positioned(
//                                             bottom: 0,
//                                             child: Container(
//                                               height: 40,
//                                               width: 200,
//                                               decoration: BoxDecoration(
//                                                 color: Colors.black,
//                                               ),
//                                               child: Center(
//                                                 child: AppText(
//                                                   data: "View Details",
//                                                   color: Colors.white,
//                                                 ),
//                                               ),
//                                             ))
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             });
//                       }
//
//                       return Center(
//                         child: Text("No data"),
//                       );
//                     },
//                   )),
//             )
//           ],
//         ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:rescuerun/components/apptext.dart';
import 'package:rescuerun/views/users/usermapscreen.dart';
import 'package:rescuerun/views/users/viewallambulanceuser.dart';
import 'package:rescuerun/views/users/viewallfeedbacksuser.dart';
import 'package:rescuerun/views/users/viewallnotificationuser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../common/Login_page.dart';
import '../../constant/colors.dart';
import '../../models/hospitalmodel.dart';
import '../../services/hospitalservice.dart';
import '../../services/userservice.dart';
import 'bookinghistory.dart';
import 'hospitaldetails.dart';
class UserHomePage extends StatefulWidget {
  final Map?snap;
  final String?name;
  final String?email;
  final String?phone;
  final String?id;
  const UserHomePage(
      {Key? key,this.snap,this.name, this.email, this.phone,this.id})
      : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  String?_name;
  // var _name;
  String? _email;
  String? _phone;
  String? token;
  String?_id;
  UserService userService = UserService();

  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    token = await _pref.getString('token');
    _name = await _pref.getString('name',);
    _email = await _pref.getString('email',);
    _phone = await _pref.getString('phone',);
    _id = await _pref.getString('uid',);
    setState(() {});
  }
  List<String>? categories = [
    "Ambulance",
  ];
  List<Widget> icons = [
    FaIcon(
      FontAwesomeIcons.truckMedical,
      color: Colors.white,
    ),
  ];

  HospitalService _hospitalService = HospitalService();
  @override
  void initState() {
    getData();
    super.initState();
  }
  var uuid=Uuid();
  @override
  Widget build(BuildContext context) {
    print(_name.toString());
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      drawer: Drawer(
        backgroundColor: Colors.teal,
        child: ListView(
          children: [
            DrawerHeader(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(

                      child: AppText(data:'${_name?[0]??''}',),

                    ),
                    SizedBox(width: 20,),
                    AppText(data: _name?.toString()??'',color: Colors.white,)
                  ],
                )
              ],
            )
            ),
            // ListTile(
            //     title:Row(
            //       children: [
            //         IconButton(onPressed:(){},icon:FaIcon(FontAwesomeIcons.user,color: Colors.white,) ,),
            //         AppText(data:"My Profile",color: Colors.white,),
            //       ],
            //     ),
            //     onTap:(){
            //       Navigator.push(context, MaterialPageRoute(builder: (context)=>UserProfile(
            //
            //
            //       )));
            //     }
            // ),
        ListTile(
                title:Row(
                  children: [
                    IconButton(onPressed:(){},icon:FaIcon(FontAwesomeIcons.book,color: Colors.white,) ,),
                    AppText(data:"My Bookings",color: Colors.white,),
                  ],
                ),
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingHistory(

                    id: _id,
                  )));
                }
            ),
            ListTile(
                title:Row(
                  children: [
                    IconButton(onPressed:(){},icon:FaIcon(FontAwesomeIcons.comments,color: Colors.white,) ,),
                    AppText(data:"Feedback History",color: Colors.white,),
                  ],
                ),
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllFeedbacksUsers(userid: _id,)));
                }
            ),
            ListTile(
                title:Row(
                  children: [
                    IconButton(onPressed:(){},icon:FaIcon(FontAwesomeIcons.arrowRightFromBracket,color: Colors.white,) ,),
                    AppText(data:"Logout",color: Colors.white,),
                  ],
                ),
                onTap:(){
                  userService.logOut();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
                }
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: AppText(
          // data:"Welcome ${_name.toString()}",
          data: "Welcome ${_name?.toString()?? ''}",
          // data: "Welcome  ${_name}",
          // data: "Welcome ! ",
          color: Colors.white,
          fw: FontWeight.bold,
          size: 22,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewAllNotificationUser()));
            },
            icon: FaIcon(
              FontAwesomeIcons.bell,
              color: Colors.yellow,
            ),
          )
        ],
      ),

        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      data: "Always ready",
                      size: 28,
                      color:Colors.blue.shade900,
                      fw: FontWeight.bold,
                    ),
                AppText(
                              data: "anytime & anywhere!",
                              size: 28,
                              color: Colors.blue.shade900,
                              fw: FontWeight.bold,
                            ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: AppText(
                    data: "For IP Patients",
                    size: 20,
                    color: Colors.blue.shade900,
                    fw: FontWeight.bold,
                  )),
            ),

            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ViewAllAmbulancesUser(cat: "ip",)));
                        },
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                icons[index],
                                AppText(
                                  data: categories![index],
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: AppText(
                    data: "Services by Category",
                    size: 20,
                    color: Colors.blue.shade900,
                    fw: FontWeight.bold,
                  )),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ViewAllAmbulancesUser()));
                        },
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                              color:Colors.teal,
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                icons[index],
                                AppText(
                                  data: categories![index],
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserMapScreen()));
                },
                child: Container(
                  height: 80,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors().primaryColor.withOpacity(0.3)),
                  child: Row(
                    children: [
                      Lottie.asset('assets/json/ambulance.json'),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: AppText(
                          data: "Ambulances Near You",
                          color: AppColors().textColor2,
                          size: 18,
                        ),
                      ),
                      FaIcon(
                        FontAwesomeIcons.circleArrowRight,
                        color: AppColors().textColor2,
                        size: 28,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: AppText(
                    data: "Hospitals near you",
                    size: 20,
                    color: AppColors().textColor2,
                    fw: FontWeight.bold,
                  )),
            ),
            SliverToBoxAdapter(
              child: Container(
                  padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  height: 330,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                    future: _hospitalService.getAllHospitals(),
                    builder: (_, snapshot) {


                      if (snapshot.hasData) {
                        List<HospitalModel> hospitals =
                        snapshot.data as List<HospitalModel>;
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: hospitals.length,
                            itemBuilder: (context, index) {
                              var hospital = hospitals[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HospitalDetailsPage(
                                                snap: hospital,
                                              )));
                                },
                                child: Card(
                                  child: Container(
                                    width: 200,
                                    color: Colors.white,
                                    height: 330,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 160,
                                          width: 200,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      'assets/images/hospital1.jpg'),

                                              )
                                          ),
                                        ),
                                        Positioned(
                                            left: 45,
                                            right: 10,
                                            bottom: 80,
                                            child: AppText(
                                              data: hospital.hname,
                                              fw: FontWeight.bold,
                                              color: Colors.black54,
                                              size: 15,
                                            )),
                                        Positioned(
                                            left: 20,
                                            bottom: 50,
                                            right: 10,
                                            child: Row(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.locationPin,
                                                  color: AppColors()
                                                      .primaryColor
                                                      .withOpacity(0.5),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                AppText(
                                                  data: hospital.state,
                                                  fw: FontWeight.bold,
                                                  color: Colors.black54,
                                                  size: 15,
                                                ),
                                              ],
                                            )),
                                        Positioned(
                                            bottom: 0,
                                            child: Container(
                                              height: 40,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                color: Colors.teal,
                                              ),
                                              child: Center(
                                                child: AppText(
                                                  data: "View Details",
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }

                      return Center(
                        child: Text("No data"),
                      );
                    },
                  )),
            )
          ],
        ));
    // );
  }
}
