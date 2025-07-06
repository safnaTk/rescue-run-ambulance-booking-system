import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:rescuerun/views/hospital/viewallbookinghospip.dart';
import 'package:rescuerun/views/hospital/viewallbookingshos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/Login_page.dart';
import '../../components/apptext.dart';
import '../../models/ambulancemodel.dart';
import '../../models/messagemodel.dart';
import '../../models/patientmodel.dart';
import '../../services/ambulanceservice.dart';
import '../../services/userservice.dart';
import '../../components/customcontainer.dart';
import '../ambulance/ambulance_registration.dart';
import '../ambulance/viewallbookingambulance.dart';
import 'viewallambulances.dart';
import '../ambulance/viewallmessages.dart';
import '../users/viewallnotificationuser.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HospitalHomePage extends StatefulWidget {
  final Map? snap;
  final String? name;
  final String? email;
  final String? phone;
  const HospitalHomePage(
      {Key? key, this.snap, this.name, this.email, this.phone})
      : super(key: key);

  @override
  State<HospitalHomePage> createState() => _HospitalHomePageState();
}

class _HospitalHomePageState extends State<HospitalHomePage> {
  String? sender;
  String? hid;

  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    sender = await _pref.getString('name');
    hid = await _pref.getString('hid');
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  UserService userService = UserService();
  AmbulanceService _ambulanceService = AmbulanceService();
  @override
  Widget build(BuildContext context) {
    print("hello");
    return Scaffold(
        backgroundColor: Colors.green.shade200,
        drawer: Drawer(
          backgroundColor: Colors.teal,
          child: ListView(
            children: [
              DrawerHeader(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        child: AppText(
                          data: '${sender?[0] ?? ''}',
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      AppText(
                        data: sender.toString(),
                        color: Colors.white,
                      )
                    ],
                  )
                ],
              )),
              ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewAllMessagesAmbulance(
                                  hid: hid,
                                )));
                  },
                  title: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.message,
                            color: Colors.white,
                          )),
                      AppText(
                        data: "Messages",
                        color: Colors.white,
                      ),
                    ],
                  )),
              ListTile(
                  onTap: () {
                    userService.logOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false);
                  },
                  title: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.arrowRightFromBracket,
                            color: Colors.white,
                          )),
                      AppText(
                        data: "Logout",
                        color: Colors.white,
                      ),
                    ],
                  ))
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(
            "Hospital",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: FaIcon(
                  FontAwesomeIcons.arrowsRotate,
                  color: Colors.green,
                )),
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
                ))
          ],
          backgroundColor: Colors.teal,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      data: "Emergency Messages",
                      size: 22,
                      color: Colors.blue.shade900,
                      fw: FontWeight.bold,
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
                child: Container(
                    height: 130,
                    width: 200,
                    child: FutureBuilder(
                        future: _ambulanceService
                            .getallEmergencyMessagesAmbulance(hid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<MessageModel> message =
                                snapshot.data as List<MessageModel>;

                            if (message.length > 0) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: message.length,
                                  itemBuilder: (context, index) {
                                    var msg = message[index];
                                    print(msg.title);
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10, top: 20),
                                      child: CustomContainer(
                                        ontap: () {},
                                        height: 100,
                                        width: 230,
                                        decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top: 25,
                                                left: 20,
                                                right: 10,
                                                child: AppText(
                                                  size: 16,
                                                  fw: FontWeight.bold,
                                                  data: "${msg.title}",
                                                  color: Colors.white,
                                                )),
                                            Positioned(
                                                top: 45,
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
                            }
                          } else {
                            return Center(
                              child: Lottie.asset('assets/json/loading.json'),
                            );
                          }

                          return Center(
                            child: Lottie.asset('assets/json/empty.json'),
                          );
                        }))),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      data: "Patient Data",
                      size: 22,
                      color: Colors.blue.shade900,
                      fw: FontWeight.bold,
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
                child: Container(
                    height: 130,
                    width: 300,
                    child: FutureBuilder(
                        future: _ambulanceService.getallpatientData(hid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<PatientModel> message =
                                snapshot.data as List<PatientModel>;

                            if (message.length > 0) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: message.length,
                                  itemBuilder: (context, index) {
                                    var msg = message[index];

                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10, top: 20),
                                      child: CustomContainer(
                                        ontap: () {},
                                        height: 100,
                                        width: 260,
                                        decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top: 25,
                                                left: 20,
                                                right: 10,
                                                child: AppText(
                                                  size: 16,
                                                  fw: FontWeight.bold,
                                                  data: "Name: ${msg.name}",
                                                  color: Colors.white,
                                                )),
                                            Positioned(
                                                top: 45,
                                                left: 20,
                                                right: 10,
                                                child: AppText(
                                                  data:
                                                      "Condition:${msg.condition}",
                                                  color: Colors.white,
                                                )),
                                            Positioned(
                                                top: 63,
                                                left: 20,
                                                right: 10,
                                                child: AppText(
                                                  data:
                                                      "Requirement: ${msg.remarks}",
                                                  color: Colors.white,
                                                )),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }
                          } else {
                            return Center(
                              child: Lottie.asset('assets/json/loading.json'),
                            );
                          }

                          return Center(
                            child: Lottie.asset('assets/json/empty.json'),
                          );
                        }))),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      data: "Active Ambulances",
                      size: 22,
                      color: Colors.blue.shade900,
                      fw: FontWeight.bold,
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
                child: Container(
                    height: 150,
                    child: FutureBuilder(
                        future: _ambulanceService.GetAllAmbulancebyhid(
                            hid.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<AmbulanceModel> ambulances =
                                snapshot.data as List<AmbulanceModel>;

                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: ambulances.length,
                                itemBuilder: (context, index) {
                                  var ambulance = ambulances[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: CustomContainer(
                                      ontap: () {},
                                      height: 100,
                                      width: 220,
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              left: 20,
                                              top: 0,
                                              bottom: 0,
                                              child: Center(
                                                  child: FaIcon(
                                                FontAwesomeIcons.truckMedical,
                                                color: Colors.white,
                                              ))),
                                          Positioned(
                                              top: 50,
                                              bottom: 20,
                                              left: 60,
                                              right: 10,
                                              child: AppText(
                                                data: ambulance.ampRegNo,
                                                color: Colors.white,
                                              )),
                                          Positioned(
                                              top: 70,
                                              bottom: 20,
                                              left: 60,
                                              right: 10,
                                              child: AppText(
                                                data:
                                                    "Driver: ${ambulance.driverName}",
                                                color: Colors.white,
                                              )),
                                          Positioned(
                                              bottom: 0,
                                              child: Container(
                                                  height: 40,
                                                  width: 220,
                                                  color: ambulance
                                                              .avilableStatus ==
                                                          1
                                                      ? Colors.green
                                                      : Colors.red,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      AppText(
                                                        data: ambulance
                                                                    .avilableStatus ==
                                                                1
                                                            ? "Available"
                                                            : "Busy",
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ))),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }

                          return Center(
                            child: Text("no data"),
                          );
                        }))),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      data: "Ambulance Management",
                      size: 22,
                      color: Colors.blue.shade900,
                      fw: FontWeight.bold,
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 300,
                child: GridView.count(
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 5 / 3,
                  crossAxisCount: 2,
                  children: [
                    CustomContainer(
                      ontap: () {
                        final user = FirebaseAuth.instance.currentUser;

                        if (user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AmbulanceRegistration(
                                amp_type: "hospital",
                                ownerId: user.uid, // hospital UID passed here
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    "Please login to register an ambulance")),
                          );
                        }
                      },

                      //                {
                      //                 Navigator.push(
                      //                     context,
                      //                     MaterialPageRoute(
                      //                         builder: (context) => AmbulanceRegistration(amp_type: "hospital",
                      // ownerId: hospitalUID,)));
                      //               },
                      width: 220,
                      decoration: BoxDecoration(
                          color: Colors.teal.shade400,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: FaIcon(
                            FontAwesomeIcons.truckMedical,
                            color: Colors.white,
                          )),
                          SizedBox(
                            height: 20,
                          ),
                          FaIcon(
                            FontAwesomeIcons.plus,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    CustomContainer(
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewAllAmbulances(
                                      hid: hid,
                                    )));
                      },
                      width: 220,
                      decoration: BoxDecoration(
                          color: Colors.teal.shade400,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: FaIcon(
                            FontAwesomeIcons.truckMedical,
                            color: Colors.white,
                          )),
                          SizedBox(
                            height: 20,
                          ),
                          AppText(
                            data: "View All",
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    CustomContainer(
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewAllAmbulances(
                                      type: "track",
                                      hid: hid,
                                    )));
                      },
                      width: 220,
                      decoration: BoxDecoration(
                          color: Colors.teal.shade400,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: FaIcon(
                            FontAwesomeIcons.truckMedical,
                            color: Colors.white,
                          )),
                          SizedBox(
                            height: 20,
                          ),
                          AppText(
                            data: "Track",
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    CustomContainer(
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewAllAmbulances(
                                      type: "message",
                                      hid: hid,
                                    )));
                      },
                      width: 220,
                      decoration: BoxDecoration(
                          color: Colors.teal.shade400,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: FaIcon(
                            FontAwesomeIcons.truckMedical,
                            color: Colors.white,
                          )),
                          SizedBox(
                            height: 20,
                          ),
                          AppText(
                            data: "Send Messages",
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    CustomContainer(
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewAllBookingHos(
                                      id: hid,
                                    )));
                      },
                      width: 220,
                      decoration: BoxDecoration(
                          color: Colors.teal.shade400,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: FaIcon(
                            FontAwesomeIcons.truckMedical,
                            color: Colors.white,
                          )),
                          SizedBox(
                            height: 20,
                          ),
                          AppText(
                            data: " Bookings",
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    CustomContainer(
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewAllBookingHosIp(
                                      id: hid,
                                    )));
                      },
                      width: 220,
                      decoration: BoxDecoration(
                          color: Colors.teal.shade400,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: FaIcon(
                            FontAwesomeIcons.truckMedical,
                            color: Colors.white,
                          )),
                          SizedBox(
                            height: 20,
                          ),
                          AppText(
                            data: "IP Bookings",
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}
