// import 'package:cloud_firestore/cloud_firestore.dart';

// class HospitalModel {
//   String? hid;
//   String? email;
//   String? hname;
//   String? estyear;
//   String? regno;
//   String? ownership;
//   String? pan_no;
//   String? address;
//   String? city;
//   String? state;
//   String? pincode;
//   String? contactno;
//   String? website;
//   String? password;
//   String? usertype;
//   int? status;
//   DateTime? createdat;
//   String? imgurl;

//   HospitalModel(
//       {this.hid,
//         this.email,
//         this.hname,
//         this.estyear,
//         this.regno,
//         this.ownership,
//         this.pan_no,
//         this.address,
//         this.city,
//         this.state,
//         this.pincode,
//         this.contactno,
//         this.website,
//         this.password,
//         this.createdat,
//         this.status,
//         this.usertype,
//         this.imgurl
//       });

//   factory HospitalModel.fromSnapshot(DocumentSnapshot snapshot) {
//     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
//     return HospitalModel(
//         hid: snapshot['hid'],
//         city: snapshot['city'],
//         hname: snapshot['hname'],
//         ownership: snapshot['ownership'],
//         pincode: snapshot['pincode'],
//         state: snapshot['state'],
//         regno: snapshot['regdno'],
//         address: snapshot['address'],
//         email: snapshot['email'],
//         contactno: snapshot['contactno'],
//         website: snapshot['website']
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class HospitalModel {
  String? hid;
  String? email;
  String? hname;
  String? estyear;
  String? regno;
  String? ownership;
  String? pan_no;
  String? address;
  String? city;
  String? state;
  String? pincode;
  String? contactno;
  String? website;
  String? password;
  String? usertype;
  int? status;
  DateTime? createdat;
  String? imgurl;

  HospitalModel({
    this.hid,
    this.email,
    this.hname,
    this.estyear,
    this.regno,
    this.ownership,
    this.pan_no,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.contactno,
    this.website,
    this.password,
    this.usertype,
    this.status,
    this.createdat,
    this.imgurl,
  });

  factory HospitalModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return HospitalModel(
      hid: data['hid'],
      email: data['email'],
      hname: data['hname'],
      estyear: data['estyear'],
      regno: data['regdno'],
      ownership: data['ownership'],
      pan_no: data['pan_no'],
      address: data['address'],
      city: data['city'],
      state: data['state'],
      pincode: data['pincode'],
      contactno: data['contactno'],
      website: data['website'],
      password: data['password'],
      usertype: data['userType'],
      status: data['status'],
      imgurl: data['imgurl'],
      createdat: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
    );
  }
}
