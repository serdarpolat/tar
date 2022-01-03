import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String img;
  final String name;
  final String lastMsg;
  final Timestamp time;
  final int unreadCount;

  ChatModel({
    required this.img,
    required this.name,
    required this.lastMsg,
    required this.time,
    required this.unreadCount,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      img: map['img'],
      name: map['name'],
      lastMsg: map['lastMsg'],
      time: map['time'],
      unreadCount: map['unreadCount'],
    );
  }
}

class ChatShort {
  final String chatUid;
  final List<dynamic> members;

  ChatShort({
    required this.chatUid,
    required this.members,
  });

  factory ChatShort.fromSnapshot(DocumentSnapshot snap) {
    return ChatShort(
      chatUid: snap.id,
      members: snap['members'],
    );
  }
}
