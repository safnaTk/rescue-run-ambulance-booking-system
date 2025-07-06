
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../models/ambulancemodel.dart';
// import '../models/hospitalmodel.dart';

// class HospitalService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final CollectionReference _userCollection =
//   FirebaseFirestore.instance.collection('user');
//   // final CollectionReference _hospitalCollection =
//   // FirebaseFirestore.instance.collection('hospital');

//   Future<void> registerUser(HospitalModel hospital) async {
//     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: hospital.email.toString(),
//         password: hospital.password.toString());

//     await _userCollection.doc(userCredential.user!.uid).set({
//       "hid": userCredential.user!.uid,
//       "email": hospital.email,
//       "hname": hospital.hname,
//       "estyear": hospital.estyear,
//       "regdno": hospital.regno,
//       "ownership": hospital.ownership,
//       "pan_no": hospital.pan_no,
//       "address": hospital.address,
//       "city": hospital.city,
//       "state": hospital.state,
//       "pincode": hospital.pincode,
//       "contactno": hospital.contactno,
//       "website": hospital.website,
//       "password": hospital.password,
//       "userType": "hospital",
//       "imgurl": hospital.imgurl,
//       "status": 1,
//       "createdAt": DateTime.now()
//     }).then((value) => null);
//   }

//   Future<List<HospitalModel>> GetAllHospital() async {
//     QuerySnapshot snap =
//     await _userCollection.where('userType', isEqualTo: "hospital").get();

//     List<HospitalModel> data = [];

//     for (var snapshot in snap.docs) {
//       HospitalModel hospital = HospitalModel.fromSnapshot(snapshot);
//       data.add(hospital);
//     }

//     return data;
//   }

//   Future<List<AmbulanceModel>> GetAllAmbulance(String?hid) async {
//     QuerySnapshot snap =
//     await _userCollection.where('userType', isEqualTo: "ambulance").where(
//         'ownerid', isEqualTo: hid.toString()).get();

//     List<AmbulanceModel> data = [];

//     for (var snapshot in snap.docs) {
//       AmbulanceModel ambulance = AmbulanceModel.fromSnapshot(snapshot);
//       data.add(ambulance);
//       print(ambulance.category);
//     }

//     return data;
//   }
// }
// Updated hospitalservice.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../models/hospitalmodel.dart';

// class HospitalService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final CollectionReference _userCollection = FirebaseFirestore.instance.collection('user');

//   Future<String?> registerUser(HospitalModel hospital) async {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: hospital.email!,
//         password: hospital.password!,
//       );

//       await _userCollection.doc(userCredential.user!.uid).set({
//         "hid": userCredential.user!.uid,
//         "email": hospital.email,
//         "hname": hospital.hname,
//         "estyear": hospital.estyear,
//         "regdno": hospital.regno,
//         "ownership": hospital.ownership,
//         "pan_no": hospital.pan_no,
//         "address": hospital.address,
//         "city": hospital.city,
//         "state": hospital.state,
//         "pincode": hospital.pincode,
//         "contactno": hospital.contactno,
//         "website": hospital.website,
//         "password": hospital.password,
//         "userType": "hospital",
//         "imgurl": hospital.imgurl,
//         "status": 1,
//         "createdAt": DateTime.now()
//       });
//       return null;
//     } catch (e) {
//       return e.toString();
//     }
//   }

//   // Future<List<HospitalModel>> getAllHospitals() async {
//   //   QuerySnapshot snap = await _userCollection.where("userType", isEqualTo: "hospital").get();
//   //   return snap.docs.map((doc) => HospitalModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
//   // }
//   Future<List<HospitalModel>> getAllHospitals() async {
//   QuerySnapshot snap = await _userCollection.where("userType", isEqualTo: "hospital").get();
//   return snap.docs.map((doc) => HospitalModel.fromSnapshot(doc)).toList();
// }

// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/hospitalmodel.dart';
import '../models/ambulancemodel.dart';

class HospitalService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('user');

  Future<String?> registerUser(HospitalModel hospital) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: hospital.email!,
        password: hospital.password!,
      );

      await _userCollection.doc(userCredential.user!.uid).set({
        "hid": userCredential.user!.uid,
        "email": hospital.email,
        "hname": hospital.hname,
        "estyear": hospital.estyear,
        "regdno": hospital.regno,
        "ownership": hospital.ownership,
        "pan_no": hospital.pan_no,
        "address": hospital.address,
        "city": hospital.city,
        "state": hospital.state,
        "pincode": hospital.pincode,
        "contactno": hospital.contactno,
        "website": hospital.website,
        "password": hospital.password,
        "userType": "hospital",
        "imgurl": hospital.imgurl,
        "status": 1,
        "createdAt": DateTime.now()
      });
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<HospitalModel>> getAllHospitals() async {
    QuerySnapshot snap = await _userCollection
        .where("userType", isEqualTo: "hospital")
        .get();
    return snap.docs
        .map((doc) => HospitalModel.fromSnapshot(doc))
        .toList();
  }

  Future<List<AmbulanceModel>> getAllAmbulance(String? hospitalId) async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("ambulance")
        .where("hospital_id", isEqualTo: hospitalId)
        .get();

    return snap.docs.map((doc) {
      return AmbulanceModel.fromSnapshot(doc);
    }).toList();
  }
}
