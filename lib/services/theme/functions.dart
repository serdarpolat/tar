import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Routing {
  static pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static push(BuildContext context, Widget child) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => child),
    );
  }

  static pushRep(BuildContext context, Widget child) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => child),
    );
  }
}

String getTime(Timestamp senttime) {
  DateTime time = senttime.toDate();
  String date = "";

  if (time.day == DateTime.now().day) {
    date = time.hour.toString() + ":" + time.minute.toString();
  } else {
    date = time.toString().split(" ").first.split("-")[2] +
        "/" +
        time.toString().split(" ").first.split("-")[1];
  }

  return date;
}

setMessageAsRead(String chatId, String myUid) async {
  var msgDocs = FirebaseFirestore.instance
      .collection('chats')
      .doc(chatId)
      .collection('messages')
      .where('senderId', isNotEqualTo: myUid)
      .snapshots();

  await msgDocs.forEach((el) async {
    List<DocumentSnapshot> docs = el.docs;

    for (var doc in docs) {
      await doc.reference.update({'status': 'read'});
    }
  });
}
