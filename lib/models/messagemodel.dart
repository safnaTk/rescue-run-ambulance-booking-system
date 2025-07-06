import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? msgid;
  String? title;
  String? message;
  String? sender;
  String? receiver;
  DateTime? date;
  int? status;
  String?reply;
 int?replystatus;

  MessageModel(
      {this.message,
        this.replystatus,
        this.status,
        this.reply,
        this.date,
        this.msgid,
        this.receiver,
        this.sender,
        this.title});



  factory MessageModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return MessageModel(
      msgid: snapshot['msgid'],
      title: snapshot['title'],
      message: snapshot['message'],
      sender: snapshot['sender'],
      receiver: snapshot['recevier'],
      status: snapshot['status'],
      reply: snapshot['reply'],
      replystatus: snapshot['replystatus']??"",




    );
  }




}