import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel {

  String?age;
  String?msgid;
  String?hid;
  String?ampid;
  int?status;
  var createdat;
  String?name;
  String?condition;
  String?address;
  String?remarks;




  PatientModel({this.msgid,this.age,this.name,this.address,this.condition,this.remarks,this.hid,this.ampid,this.status,this.createdat});
  factory PatientModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return PatientModel(
        age: snapshot['age'],
        name: snapshot['name'],
        condition: snapshot['condition'],
        address: snapshot['address'],
        remarks: snapshot['remarks'],
        status: snapshot['status'],
        hid: snapshot['hid'],
        ampid: snapshot['ampid']

    );
  }
}