import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ambulancebook.dart';
class UserMapScreen extends StatefulWidget {
  const UserMapScreen({Key? key}) : super(key: key);

  @override
  State<UserMapScreen> createState() => _UserMapScreenState();
}

class _UserMapScreenState extends State<UserMapScreen> {
  BitmapDescriptor? customIcon;
  late String _name;
  late String _uid;
  late String _email;
  late String _phone;
  var latitude;
  var longitude;
  late String uid;
  late int a;
  _launchMapsApp(double latitude, double longitude) {
    return launchUrl(
        Uri.parse('https://maps.google.com/?q=$latitude,$longitude'));
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  Completer<GoogleMapController> _controller = Completer();




  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  var myposition;
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _name = prefs.getString("name")!;
    _uid = prefs.getString('uid')!;
    _email = prefs.getString("email")!;
    _phone = prefs.getString("phone")!;

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("user")
        .where('usertype', isEqualTo: 'ambulance')
        .get();
    a = snapshot.docs.length;
    print(a);
  }

  List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(10.9726428, 76.2266938),
        infoWindow: InfoWindow(title: 'some info'))
  ];

  _showBottomSheet(
      {String? name,
        String? Owner,
        String? Phone,
        String?cat,
        lat2,
        lon2,
        uid,
        String? Place}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          double dis = calculateDistance(latitude, longitude, lat2, lon2) ?? 0;

          return Container(
            height: 160,
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Color(0xFFFedeef0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(
                        name.toString() ?? "",
                        style: GoogleFonts.comicNeue(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFE30B5C)),
                      ),
                      Expanded(
                        child: Container(
                          height: 20,
                        ),
                      ),
                      Text(
                        "${dis.toStringAsFixed(2)} km",
                        style: GoogleFonts.comicNeue(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.pinkAccent),
                      ),
                    ]),

                    Row(
                      children: [
                        Text(
                          Phone.toString() ?? "",
                          style: GoogleFonts.comicNeue(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        Expanded(
                          child: Container(
                            height: 20,
                          ),
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () async {

                                _makePhoneCall(Phone!);

                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>BookAmbulance(
                                // ampid: uid,
                                // drivername: name,
                                // driverPhone: Phone,
                                // location: GeoPoint(lat2,lon2),
                                // )));

                              },
                              child: SizedBox(
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.white,
                                  )),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFE30B5C),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(350)),

                                // side: BorderSide(color: Colors.yellow, width: 5),
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal),
                              ),
                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(
                              onPressed: () async {

                                // _makePhoneCall(Phone!);
                                print(cat);

                                Navigator.push(context, MaterialPageRoute(builder: (context)=>BookAmbulance(
                                  ampid: uid,
                                  cat:cat ,
                                  drivername: name,
                                  driverPhone: Phone,
                                  location: GeoPoint(lat2,lon2),
                                )));

                              },
                              child: SizedBox(
                                  child: Icon(
                                    Icons.message,
                                    color: Colors.white,
                                  )),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFE30B5C),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(350)),

                                // side: BorderSide(color: Colors.yellow, width: 5),
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  //creating Marker Model
  void initMarker(specify, specifyId) async {
    var markerIdval = specifyId;
    final MarkerId markerId = MarkerId(markerIdval);
    final Marker marker = Marker(
        onTap: () {
          _showBottomSheet(

              uid: specify['ampid'],
              Phone: specify['driverPhone'],
              name: specify['driverName'],
              lat2: specify['location'].latitude,
              lon2: specify['location'].longitude);
        },
        markerId: markerId,
        position:
        LatLng(specify['location'].latitude, specify['location'].longitude),
        infoWindow: InfoWindow(
            title: specify['driverName'], snippet: specify['driverPhone']),
        icon: BitmapDescriptor.defaultMarkerWithHue(2));

    setState(() {
      markers[markerId] = marker;
    });
  }

  //dynamic Markers
  getMarkerData() async {
    FirebaseFirestore.instance
        .collection('user')
        .where("userType", isEqualTo: "ambulance")
        .where('availableStatus', isEqualTo: 1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (int i = 0; i < value.docs.length; i++) {
          initMarker(value.docs[i].data(), value.docs[i].id);
        }
      }
    });
  }

  bool _location = false;

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {
      getUserCurrentLocation().then((value) async {
        // print('my current location');
        // print(value.toString());
        // print(value.latitude.toString()+""+value.longitude.toString());
        myposition = LatLng(value.latitude, value.longitude);
        latitude = value.latitude;
        longitude = value.longitude;

        if (myposition != null) {
          setState(() {
            _location = true;
          });
        }
        _markers.add(Marker(
            markerId: MarkerId('2'),
            position: LatLng(value.latitude, value.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet),
            infoWindow: InfoWindow(title: 'Hello')));
        CameraPosition cameraPosition = CameraPosition(
            zoom: 14, target: LatLng(value.latitude, value.longitude));

        final GoogleMapController controller = await _controller.future;
        controller
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        setState(() {});
      });
    }).onError((error, stackTrace) {
      print("error" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: myposition,
  //   zoom: 14.4746,
  // );

  Future<void> _checkPermissions() async {
    if (await Permission.location.request().isGranted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserCurrentLocation();
    print(markers);
    _loadData();
    getMarkerData();

    // BitmapDescriptor.fromAssetImage(
    //
    //     ImageConfiguration(devicePixelRatio: 2.5,), 'asset/marker.png')
    //     .then((icon) {
    //   setState(() {
    //     customIcon = icon;
    //   });
    // });
  }

  @override
  void dispose() {

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0.0,
      ),
        body: buildGoogleMap()
    );
  }

  GoogleMap buildGoogleMap() {
    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: _location ? myposition : LatLng(10.9757, 76.2263),
            zoom: 10),
        markers: Set<Marker>.of(markers.values),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      );
  }
}
