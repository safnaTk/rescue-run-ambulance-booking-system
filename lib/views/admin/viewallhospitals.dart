import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/apptext.dart';
import '../../models/hospitalmodel.dart';
import '../../services/hospitalservice.dart';
import '../users/hospitaldetails.dart';
class ViewAllHospitals extends StatefulWidget {
  const ViewAllHospitals({super.key});

  @override
  State<ViewAllHospitals> createState() => _ViewAllHospitalsState();
}

class _ViewAllHospitalsState extends State<ViewAllHospitals> {
  @override
  Widget build(BuildContext context) {
    HospitalService _hospitalService=HospitalService();
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: AppText(data:"All Hospitals",color: Colors.white,),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: FutureBuilder(
          future: _hospitalService.getAllHospitals(),
          //future:_hospitalService.GetAllHospital(),
          builder: (_, snapshot) {


            if(snapshot.hasError){

              return Center(
                child: Text("Something went wrong"),
              );
            }

            if (snapshot.hasData) {

              List<HospitalModel> hospitals =
              snapshot.data as List<HospitalModel>;
              return ListView.builder(
                  scrollDirection: Axis.vertical,
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
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),

                        color: Colors.white,
                        height: 270,
                        child: Stack(
                          children: [
                            Container(
                              height: 160,

                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/images/hospital1.jpg'))),
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
                                      color:Colors.pink.shade100
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
                                  width: MediaQuery.of(context).size.width,
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
                    );
                  });
            }

            return Center(
              child: CircularProgressIndicator()
            );
          },
        ),
      ),
    );
  }
}
