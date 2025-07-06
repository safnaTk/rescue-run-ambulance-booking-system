import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {

  String?category;
  String? bookingid;
  String? cause;
  String? location;
  String? sendername;
  String? senderid;
  String? senderPhone;
  String? senderEmail;

  String? receiverPhone;
  String? reciverId;

  DateTime? date;
  int? status;
  String? casualities;
  int? bookingstatus;
  String? hid;


  BookingModel({
    this.hid,
    this.category,
    this.bookingstatus,
    this.casualities,
    this.location,
    this.senderid,
    this.status,
    this.senderEmail,
    this.sendername,
    this.senderPhone,
    this.cause,
    this.receiverPhone,
    this.reciverId,
    this.bookingid,
    this.date,
  });

  factory BookingModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return BookingModel(

        bookingid: snapshot['bookingid'],
        hid: snapshot['hid'],
        category: snapshot['category'],
        cause: snapshot['cause'],
        bookingstatus: snapshot['bookingstatus'],
        status: snapshot['status'],
        sendername: snapshot['sendername'],
        senderEmail: snapshot['senderEmail'],
        senderPhone: snapshot['senderPhone'],
        receiverPhone: snapshot['receiverPhone'],
        reciverId: snapshot['reciverId'],
        location: snapshot['location'],
        senderid: snapshot['senderid'],
        casualities: snapshot['casualities']



    );
  }
}