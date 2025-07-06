import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/feedbackmodel.dart';

class FeedbackService {
  final CollectionReference _feedback =
      FirebaseFirestore.instance.collection('feedback');

  Future<void> sendFeedback(FeedbackModel message) async {
    await _feedback.doc(message.msgid).set({
      'msgid': message.msgid,
      'title': message.title,
      'message': message.message,
      'senderid': message.senderid,
      'sendername': message.sendername,
      'senderphone': message.senderphone,
      'reply': message.reply,
      'replystatus': 0,
      'recevier': message.receiver,
      'createdat': DateTime.now(),
      'status': message.status,
      'ampid': message.houseid
    });
  }

  Future<void> updateFeedback(FeedbackModel message) async {
    await _feedback.doc(message.msgid).update({
      'reply': message.reply,
      'replystatus': 1,
    });
  }

  Future<List<FeedbackModel>> getallFeedbacks() async {
    QuerySnapshot snap = await _feedback.get();
    print(snap.size);
    List<FeedbackModel> data = [];

    for (var snapshot in snap.docs) {
      print("hi jobin");
      FeedbackModel message = FeedbackModel.fromSnapshot(snapshot);
      data.add(message);
      print(message.title);
    }

    return data;
  }

  Future<void> deleteFeedback(String? id) async {
    await _feedback.doc(id).update({'status': 0});
  }

  Future<List<FeedbackModel>> getFeedbackuser(String? uid) async {
    QuerySnapshot snap = await _feedback
        .where('senderid', isEqualTo: uid.toString())
        .where('status', isEqualTo: 1)
        .get();
    print(snap.size);
    List<FeedbackModel> data = [];

    for (var snapshot in snap.docs) {
      print("hi jobin");
      FeedbackModel message = FeedbackModel.fromSnapshot(snapshot);
      data.add(message);
      print(message.title);
    }

    return data;
  }

  Future<List<FeedbackModel>> getFeedbyambulance(String? ampid) async {
    QuerySnapshot snap =
        await _feedback.where('ampid', isEqualTo: ampid.toString()).get();
    print(snap.size);
    List<FeedbackModel> data = [];

    for (var snapshot in snap.docs) {
      print("hi jobin sebastian");
      FeedbackModel message = FeedbackModel.fromSnapshot(snapshot);
      data.add(message);
      print(message.title);
    }

    return data;
  }

  Future<List<FeedbackModel>> getFeedbyowner(String? ownerid) async {
    QuerySnapshot snap =
        await _feedback.where('recevier', isEqualTo: ownerid.toString()).get();
    print(snap.size);
    List<FeedbackModel> data = [];

    for (var snapshot in snap.docs) {
      print("hi jobin");
      FeedbackModel message = FeedbackModel.fromSnapshot(snapshot);
      data.add(message);
      print(message.title);
    }

    return data;
  }
}
