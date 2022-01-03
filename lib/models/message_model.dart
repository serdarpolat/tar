import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final List<dynamic> message;
  final String senderId;
  final Timestamp senttime;
  final String status;

  MessageModel({
    required this.message,
    required this.senderId,
    required this.senttime,
    required this.status,
  });

  factory MessageModel.fromSnapshot(DocumentSnapshot snap) {
    return MessageModel(
      message: snap['message'],
      senderId: snap['senderId'],
      senttime: snap['senttime'],
      status: snap['status'],
    );
  }
}
