import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/ambulancemodel.dart';
import '../models/bookingmodel.dart';
import '../models/messagemodel.dart';
import '../models/patientmodel.dart';

class AmbulanceService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference _message =
      FirebaseFirestore.instance.collection('messages');
  final CollectionReference _emessage =
      FirebaseFirestore.instance.collection('emergencymessages');

  final CollectionReference _bookings =
      FirebaseFirestore.instance.collection('ambulancebooking');
  final CollectionReference _patient =
      FirebaseFirestore.instance.collection('patientdata');

  Future<void> registerAmbulance(AmbulanceModel ambulance) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: ambulance.email.toString(),
        password: ambulance.password.toString());

    await _userCollection.doc(userCredential.user!.uid).set({
      'type': ambulance.type,
      "ampid": userCredential.user!.uid,
      "email": ambulance.email,
      'driverName': ambulance.driverName,
      'driverPhone': ambulance.driverPhone,
      'ampRegNo': ambulance.ampRegNo,
      'drivreLicense': ambulance.driverLicence,
      'location': ambulance.location,
      'ownerName': ambulance.ownerName,
      'ownerAddress': ambulance.ownerAddress,
      'ownerPhone': ambulance.driverPhone,
      'ampCategory': ambulance.category,
      'availableStatus': ambulance.avilableStatus,
      'password': ambulance.password,
      "userType": "ambulance",
      "status": 1,
      "createdAt": DateTime.now(),
      'ownerid': ambulance.ownerid == null
          ? userCredential.user!.uid
          : ambulance.ownerid
    }).then((value) => null);
  }

  Future<void> updateAmbulanceLocation(AmbulanceModel ambulance) async {
    print(ambulance.ampid);

    await _userCollection
        .doc(ambulance.ampid.toString())
        .update({'location': ambulance.location});
  }

  Future<List<AmbulanceModel>> GetAllAmbulance() async {
    QuerySnapshot snap =
        await _userCollection.where('userType',isEqualTo:"ambulance").get();

    List<AmbulanceModel> data = [];

    for (var snapshot in snap.docs) {

      AmbulanceModel ambulance = AmbulanceModel.fromSnapshot(snapshot);
      data.add(ambulance);

    }

    return data;
  }

  Future<List<AmbulanceModel>> GetAllAmbulancebyhid(String id) async {
    QuerySnapshot snap = await _userCollection
        .where('userType', isEqualTo: "ambulance")
        .where('ownerid', isEqualTo: id)
        .get();

    List<AmbulanceModel> data = [];

    for (var snapshot in snap.docs) {
      AmbulanceModel ambulance = AmbulanceModel.fromSnapshot(snapshot);
      data.add(ambulance);
      print(ambulance.category);
    }

    return data;
  }

  Future<List<AmbulanceModel>> GetAllActiveAmbulance() async {
    QuerySnapshot snap = await _userCollection
        .where('userType', isEqualTo: "ambulance")
        .where('availableStatus', isEqualTo: 1)
        .get();

    List<AmbulanceModel> data = [];

    for (var snapshot in snap.docs) {
      AmbulanceModel ambulance = AmbulanceModel.fromSnapshot(snapshot);
      data.add(ambulance);
      print(ambulance.category);
    }

    return data;
  }

  Future<void> sendMessage(MessageModel message) async {
    await _message.doc(message.msgid).set({
      'msgid': message.msgid,
      'title': message.title,
      'message': message.message,
      'sender': message.sender,
      'recevier': message.receiver,
      'createdat': DateTime.now(),
      'status': message.status,
      'reply':"",
      'replystatus':0
    });
  }

  Future<List<MessageModel>> getallMessages(String? hid) async {
    print(hid);
    QuerySnapshot snap =
        await _message.where('sender', isEqualTo: hid.toString()).where('status',isEqualTo:1).get();
    print(snap.size);
    List<MessageModel> data = [];

    for (var snapshot in snap.docs) {
      print("hi jobin");
      MessageModel message = MessageModel.fromSnapshot(snapshot);
      data.add(message);
      print(message.title);
    }

    return data;
  }

  Future<void> deleteMessage(String? id) async {
    await _message.doc(id).update({'status': 0});
  }



  Future<void> updateMessage(MessageModel message) async {
    await _message.doc(message.msgid).update({
      'reply': message.reply,
      'replystatus': 1,
    });
  }

  Future<List<MessageModel>> getallMessagesAmbulance(String? ampid) async {
    print(ampid);
    QuerySnapshot snap =
        await _message.where('recevier', isEqualTo: ampid.toString()).get();
    print(snap.size);
    List<MessageModel> data = [];

    for (var snapshot in snap.docs) {
      print("hi jobin");
      MessageModel message = MessageModel.fromSnapshot(snapshot);
      data.add(message);
      print(message.title);
    }

    return data;
  }

  Future<void> sendEmergencyMessage(MessageModel message) async {
    await _emessage.doc(message.msgid).set({
      'msgid': message.msgid,
      'title': message.title,
      'message': message.message,
      'sender': message.sender,
      'recevier': message.receiver,
      'createdat': DateTime.now(),
      'status': message.status,
      'reply':"",
      'replystatus':0
    });
  }

  Future<List<MessageModel>> getallEmergencyMessagesAmbulance(
      String? hid) async {
    QuerySnapshot snap = await _emessage
        .where('recevier', isEqualTo: hid.toString())
        .orderBy('createdat')
        .get();
    print(snap.size);
    List<MessageModel> data = [];

    for (var snapshot in snap.docs) {
      print("hi am here jobin");
      MessageModel message = MessageModel.fromSnapshot(snapshot);
      data.add(message);
      print(message.message);
    }

    return data;
  }

  Future<void> bookAmbulance(BookingModel booking) async {
    await _bookings.doc(booking.bookingid).set({
      'bookingid': booking.bookingid,
      'cause': booking.cause,
      'category': booking.category,
      'status': booking.status,
      'sendername': booking.sendername,
      'senderEmail': booking.senderEmail,
      'senderPhone': booking.senderPhone,
      'hid': booking.hid ?? booking.reciverId,
      'receiverPhone': booking.receiverPhone,
      'reciverId': booking.reciverId,
      'location': booking.location,
      'senderid': booking.senderid,
      'casualities': booking.casualities,
      'bookingstatus': 0,
      'date': DateTime.now()
    });
  }

  Future<List<BookingModel>> getAllBookingadmin() async {
    QuerySnapshot snap = await _bookings.get();
    print(snap);
    List<BookingModel> data = [];

    for (var snapshot in snap.docs) {
      print("hi jobin");
      BookingModel booking = BookingModel.fromSnapshot(snapshot);
      print(booking);
      data.add(booking);
    }

    return data;
  }

  Future<List<BookingModel>> getAllBooking(String? uid) async {
    QuerySnapshot snap =
        await _bookings.where('senderid', isEqualTo: uid.toString()).get();
    print(snap);
    List<BookingModel> data = [];

    for (var snapshot in snap.docs) {
      print("hi jobin");
      BookingModel booking = BookingModel.fromSnapshot(snapshot);
      print(booking);
      data.add(booking);
    }

    return data;
  }

  Future<List<BookingModel>> getAllBookingAmbulance(String? uid) async {
    QuerySnapshot snap = await _bookings
        .where('reciverId', isEqualTo: uid.toString())
        .where('category', isEqualTo: "emergency")
        .get();
    print(snap);
    List<BookingModel> data = [];

    for (var snapshot in snap.docs) {
      print("hi jobin");
      BookingModel booking = BookingModel.fromSnapshot(snapshot);
      print(booking);
      data.add(booking);
    }

    return data;
  }

  Future<List<BookingModel>> getAllBookingAmbulanceIP(String? uid) async {
    QuerySnapshot snap = await _bookings
        .where('reciverId', isEqualTo: uid.toString())
        .where('category', isEqualTo: "ip")
        .get();
    print(snap);
    List<BookingModel> data = [];

    for (var snapshot in snap.docs) {
      print("hi jobin");
      BookingModel booking = BookingModel.fromSnapshot(snapshot);
      print(booking);
      data.add(booking);
    }

    return data;
  }

  Future<List<BookingModel>> getAllBookingAmbulanceHS(String? uid) async {
    print("This is IP Booking");
    QuerySnapshot snap = await _bookings
        .where('hid', isEqualTo: uid.toString())
        .where('category', isEqualTo: "ip")
        .get();
    print(snap.docs.length);
    List<BookingModel> data = [];

    for (var snapshot in snap.docs) {
      print("hi jobin");
      BookingModel booking = BookingModel.fromSnapshot(snapshot);
      print(booking);
      data.add(booking);
    }

    return data;
  }


  Future<List<BookingModel>> getAllBookingHospitalIP(String? uid) async {
    print(uid);
    QuerySnapshot snap = await _bookings
        .where('hid', isEqualTo: uid.toString())
        .where('category', isEqualTo: "ip")
        .get();
    print(snap.docs.length);

    print("hello this is a ip booking");
    List<BookingModel> data = [];

    for (var snapshot in snap.docs) {
      print("hi jobin");
      BookingModel booking = BookingModel.fromSnapshot(snapshot);
      print(booking);
      data.add(booking);
    }

    return data;
  }



  Future<void> acceptBooking(BookingModel booking) async {
    print(booking.bookingid);
    print("hello ralfiz");

    await _bookings
        .doc(booking.bookingid.toString())
        .update({'bookingstatus': 1});
  }

  Future<void> updateAvailability(AmbulanceModel ambulance) async {
    print("hello ralfiz");

    await _userCollection
        .doc(ambulance.ampid.toString())
        .update({'availableStatus': 0});
  }

  Future<void> resetAvailability(AmbulanceModel ambulance) async {
    print("hello ralfiz");

    await _userCollection
        .doc(ambulance.ampid.toString())
        .update({'availableStatus': 1});
  }

  Future<void> sendpatientData(PatientModel patient) async {
    await _patient.doc(patient.msgid).set({
      'msgid': patient.msgid,
      'age': patient.age,
      'remarks': patient.remarks,
      'ampid': patient.remarks,
      'hid': patient.hid,
      'address': patient.address,
      'name': patient.name,
      'createdat': patient.createdat,
      'condition': patient.condition,
      'status': patient.status
    });
  }

  Future<List<PatientModel>> getallpatientData(String? hid) async {
    QuerySnapshot snap = await _patient
        .where('hid', isEqualTo: hid.toString())
        .orderBy('createdat')
        .get();
    print(snap.size);
    List<PatientModel> data = [];

    for (var snapshot in snap.docs) {
      print("hi am here jobin");
      PatientModel message = PatientModel.fromSnapshot(snapshot);
      data.add(message);
    }

    return data;
  }

  Future<List<BookingModel>> getAllBookingHs(String? uid) async {
    QuerySnapshot snap = await _bookings
        .where('hid', isEqualTo: uid.toString())
        .where('category', isEqualTo: "emergency")
        .get();
    print(snap);
    print("hello this is a booking");
    List<BookingModel> data = [];

    for (var snapshot in snap.docs) {
      print("hi jobin");
      BookingModel booking = BookingModel.fromSnapshot(snapshot);
      print(booking.hid);
      data.add(booking);
    }

    return data;
  }
}
