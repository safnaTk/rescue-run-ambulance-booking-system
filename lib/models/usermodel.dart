import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? name;
  String? phone;
  String? password;
  String? imgurl;
  String? location;

  UserModel(
      {this.email,
      this.name,
      this.password,
      this.phone,
      this.imgurl,
      this.location});

  //named constructors
  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      email: snapshot['email'],
      name: snapshot['name'],
      phone: snapshot['phone'],
      location: snapshot['location'],
    );
  }
}
