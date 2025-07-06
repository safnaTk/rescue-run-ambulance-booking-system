import 'package:cloud_firestore/cloud_firestore.dart';

class AmbulanceModel {
  String?type;
  String? ampid;
  String? driverName;
  String? driverPhone;
  String? ampRegNo;
  String? ownerName;
  String? ownerAddress;
  String? ownerPhone;
  String? email;
  String? category;
  String? password;
  int? status;
  String? driverLicence;
  int? avilableStatus;

  GeoPoint? location;
  String?ownerid;

  AmbulanceModel(
      {
        this.ampid,
        this.ownerid,
        this.type,
        this.driverLicence,
        this.avilableStatus,
        this.driverName,
        this.driverPhone,
        this.ampRegNo,
        this.ownerName,
        this.ownerAddress,
        this.ownerPhone,
        this.password,
        this.email,
        this.status,
        this.location,
        this.category
      });

  // Define a factory constructor to create a model object from a document snapshot
  // factory AmbulanceModel.fromSnapshot(DocumentSnapshot snapshot) {
  //   Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  //   return AmbulanceModel(
  //       type: snapshot['type'],
  //       ampid: snapshot['ampid'],
  //       driverName: snapshot['driverName'],
  //       driverPhone: snapshot['driverPhone'],
  //       ampRegNo: snapshot['ampRegNo'],
  //       driverLicence: snapshot['drivreLicense'],
  //       location: snapshot['location'],
  //       ownerName: snapshot['ownerName'],
  //       ownerAddress: snapshot['ownerAddress'],
  //       ownerPhone: snapshot['ownerPhone'],
  //       category: snapshot['ampCategory'],
  //       avilableStatus: snapshot['availableStatus'],
  //       password: snapshot['password'],
  //       status: snapshot['status'],
  //       ownerid: snapshot['ownerid']
  //   );
  // }
  factory AmbulanceModel.fromSnapshot(DocumentSnapshot snapshot) {
  Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  return AmbulanceModel(
    type: data['type'],
    ampid: data['ampid'],
    driverName: data['driverName'],
    driverPhone: data['driverPhone'],
    ampRegNo: data['ampRegNo'],
    driverLicence: data['driverLicense'], // fixed spelling
    location: data['location'],
    ownerName: data['ownerName'],
    ownerAddress: data['ownerAddress'],
    ownerPhone: data['ownerPhone'],
    category: data['ampCategory'],
    avilableStatus: data['availableStatus'], // fixed spelling
    password: data['password'],
    status: data['status'],
    ownerid: data['ownerid'],
  );
}

}