import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:rescuerun/services/hospitalservice.dart';
import 'package:rescuerun/components/apptext.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/colors.dart';
import '../../models/ambulancemodel.dart';
import '../../models/hospitalmodel.dart';
import '../../components/customcontainer.dart';

class HospitalDetailsPage extends StatefulWidget {
  HospitalModel? snap;
  HospitalDetailsPage({super.key, this.snap});
  @override
  State<HospitalDetailsPage> createState() => _HospitalDetailsPageState();
}

class _HospitalDetailsPageState extends State<HospitalDetailsPage> {
  HospitalService _hospitalService = HospitalService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        title: AppText(
          data: "Hospital Details",
          color: Colors.white,
          size: 20,
          fw: FontWeight.bold,
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                data: "Hosptal Name",
                size: 18,
              ),
              AppText(
                data: "${widget.snap!.hname}",
                size: 16,
                fw: FontWeight.normal,
              ),
              Divider(
                height: 2,
              ),
              SizedBox(
                height: 10,
              ),
              AppText(
                data: "Hospital City",
                size: 18,
              ),
              AppText(
                data: "${widget.snap!.city}",
                size: 16,
                fw: FontWeight.normal,
              ),
              Divider(
                height: 2,
              ),
              SizedBox(
                height: 10,
              ),
              AppText(
                data: "Hospital Phone",
                size: 18,
              ),
              AppText(
                data: "${widget.snap!.contactno}",
                size: 16,
                fw: FontWeight.normal,
              ),
              Divider(
                height: 2,
              ),
              SizedBox(
                height: 10,
              ),
              AppText(
                data: "Hospital Email",
                size: 18,
              ),
              AppText(
                data: "${widget.snap!.email}",
                size: 16,
                fw: FontWeight.normal,
              ),
              Divider(
                height: 2,
              ),
              SizedBox(
                height: 10,
              ),
              AppText(
                data: "Website",
                size: 18,
              ),
              AppText(
                data: "${widget.snap!.website}",
                size: 16,
                fw: FontWeight.normal,
              ),
              Divider(
                height: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  height: 45,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.teal,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        data: "Contact Now",
                        size: 18,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          _makePhoneCall(widget.snap!.contactno!);
                        },
                        child: FaIcon(
                          FontAwesomeIcons.phone,
                          color: Colors.green.shade200,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              AppText(
                data: "Available Ambulances",
                size: 18,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 130,
                child: FutureBuilder(
                    future: _hospitalService.getAllAmbulance(widget.snap!.hid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<AmbulanceModel> ambulances =
                            snapshot.data as List<AmbulanceModel>;

                        if (ambulances.length > 0) {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: ambulances.length,
                              itemBuilder: (context, index) {
                                var ambulance = ambulances[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomContainer(
                                    ontap: () {},
                                    width: 220,
                                    decoration: BoxDecoration(
                                        color: AppColors().textColor2,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            left: 20,
                                            top: 0,
                                            bottom: 50,
                                            child: Center(
                                                child: FaIcon(
                                              FontAwesomeIcons
                                                  .triangleExclamation,
                                              color: Colors.white,
                                            ))),
                                        Positioned(
                                            top: 25,
                                            left: 60,
                                            right: 10,
                                            child: AppText(
                                              data: "No: ${ambulance.ampRegNo}",
                                              color: Colors.white,
                                            )),
                                        Positioned(
                                            top: 45,
                                            left: 60,
                                            right: 10,
                                            child: AppText(
                                              data:
                                                  "Type: ${ambulance.category}",
                                              color: Colors.white,
                                            )),
                                        Positioned(
                                            bottom: 10,
                                            right: 100,
                                            left: 100,
                                            child: InkWell(
                                              onTap: () {
                                                _makePhoneCall(
                                                    ambulance.driverPhone!);
                                              },
                                              child: FaIcon(
                                                FontAwesomeIcons.phone,
                                                color: Colors.green,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  data: "No",
                                  fw: FontWeight.bold,
                                  size: 22,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Lottie.asset('assets/json/ambulance.json'),
                                SizedBox(
                                  width: 10,
                                ),
                                AppText(
                                    data: "Available",
                                    fw: FontWeight.bold,
                                    size: 22),
                              ],
                            ),
                          );
                        }
                      }

                      return Center(child: CircularProgressIndicator());
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }
}
