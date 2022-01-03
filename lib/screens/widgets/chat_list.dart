import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypted_messaging/models/user_model.dart';
import 'package:encrypted_messaging/screens/widgets/chat_item.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ChatList extends StatelessWidget {
  final QuerySnapshot<Map<String, dynamic>> data;
  final List<String>? myPrefs;
  final Box<UserModel> userBox;

  const ChatList(
      {Key? key,
      required this.data,
      required this.myPrefs,
      required this.userBox})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: data.docs.map((e) {
        UserModel? userModel;
        if (e['members'][0] != myPrefs![0]) {
          userModel = userBox.get(e['members'][0]);
        }

        if (e['members'][1] != myPrefs![0]) {
          userModel = userBox.get(e['members'][1]);
        }
        return ChatItem(e: e, userModel: userModel!, myPrefs: myPrefs);
      }).toList(),
    );
  }
}
