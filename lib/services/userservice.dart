import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/usermodel.dart';

class UserService {
  //firebase reference
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('user');

  //Register user

  Future<void> registerUser(UserModel user) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: user.email.toString(), password: user.password.toString());

    await _userCollection.doc(userCredential.user!.uid).set({
      'uid': userCredential.user!.uid,
      'email': userCredential.user!.email,
      'password': user.password,
      'name': user.name,
      'phone': user.phone,
      'location': user.location,
      'imgurl': user.imgurl,
      'status': 1,
      'userType': "user",
      'createdat': DateTime.now()
    }).then((value) => null);
  }

  //user login and sharedpreference

  Future<DocumentSnapshot> loginUser(UserModel user) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: user.email.toString(), password: user.password.toString());

    var snap = await _userCollection.doc(userCredential.user!.uid).get();

    String? token = await userCredential.user!.getIdToken();

    await _pref.setString('token', token!);
    print("Token is: $token");

    if (snap['userType'] == "user") {
      String? _name = snap['name'];
      String? _email = snap['email'];
      String? _phone = snap['phone'];
      String? _type = snap['userType'];
      String? _uid = snap['uid'];

      await _pref.setString('token', token);
      await _pref.setString('uid', _uid!);
      await _pref.setString('name', _name!);
      await _pref.setString('email', _email!);
      await _pref.setString('phone', _phone!);
      await _pref.setString('type', _type!);
    } else if (snap['userType'] == "hospital") {
      String? _name = snap['hname'];
      String? _email = snap['email'];
      String? _phone = snap['contactno'];
      String? _type = snap['userType'];
      String? _address = snap['address'];
      String? _city = snap['city'];
      String? _state = snap['state'];
      String? _web = snap['website'];
      String? _regno = snap['regdno'];
      String? _imgurl = snap['imgurl'];
      String? _hid = snap['hid'];

      await _pref.setString('token', token);
      await _pref.setString('name', _name!);
      await _pref.setString('email', _email!);
      await _pref.setString('phone', _phone!);
      await _pref.setString('type', _type!);

      await _pref.setString('address', _address!);
      await _pref.setString('city', _city!);
      await _pref.setString('state', _state!);
      await _pref.setString('web', _web!);
      await _pref.setString('regno', _regno!);
      await _pref.setString('hid', _hid!);
      //await _pref.setString('imgurl', _imgurl!);
    } else if (snap['userType'] == "ambulance") {
      String? _name = snap['driverName'];
      String? _hid = snap['ownerid'];
      String? _email = snap['email'];
      String? _phone = snap['driverPhone'];
      String? _type = snap['userType'];
      //String? _address = snap['location'];
      String? amp_tye = snap['type'];

      String? _aid = snap['ampid'];

      await _pref.setString('token', token);
      await _pref.setString('name', _name!);
      await _pref.setString('email', _email!);
      await _pref.setString('phone', _phone!);
      await _pref.setString('type', _type!);
      await _pref.setString('hid', _hid!);
      await _pref.setString('amp_type', amp_tye!);
      //await _pref.setString('address', _address!);

      await _pref.setString('ampid', _aid!);
    }
    return snap;
  }

  Future<void> logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('token');
    await pref.clear();

    String? _token = await pref.getString('token');
    print("*********");
    print(_token);
    print("*********");
  }

  Future<bool> isLoggedin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? _token = await pref.getString('token');
    if (_token == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<UserModel>> GetAllUsers() async {
    QuerySnapshot snap =
        await _userCollection.where('userType', isEqualTo: "user").get();

    List<UserModel> data = [];

    for (var snapshot in snap.docs) {
      UserModel user = UserModel.fromSnapshot(snapshot);
      data.add(user);
    }

    return data;
  }
}
