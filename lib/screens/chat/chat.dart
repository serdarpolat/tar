import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypted_messaging/models/user_model.dart';
import 'package:encrypted_messaging/screens/chat/sender.dart';
import 'package:encrypted_messaging/services/encryption/i_encryption_service.dart';
import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:flutter/material.dart';

import 'appbar.dart';

class Chat extends StatefulWidget {
  final String chatId;
  final List<String> myPrefs;
  final UserModel user;

  const Chat(
      {Key? key,
      required this.chatId,
      required this.myPrefs,
      required this.user})
      : super(key: key);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: s.width,
        height: s.height,
        color: Clr.lightBlue,
        child: Stack(
          children: [
            Container(
              width: s.width,
              height: s.height,
              padding: EdgeInsets.only(
                  top: hh(context, 100), bottom: hh(context, 86)),
            ),
            CAppbar(
              user: widget.user,
            ),
            Sender(
              msgCtrl: ctrl,
              onTap: () async {
                if (ctrl.text.isNotEmpty) {
                  final _encService = IEncryptionService();
                  var msg0 =
                      _encService.encrypt(widget.user.publicKey, ctrl.text);
                  var msg1 = _encService.encrypt(widget.myPrefs[5], ctrl.text);
                  await FirebaseFirestore.instance
                      .collection(Vars.chatsCol)
                      .doc(widget.chatId)
                      .collection(Vars.msgCol)
                      .add({
                    'message': [msg0, msg1],
                    'senderId': widget.myPrefs[0],
                    'senttime': Timestamp.now(),
                    'status': 'unread',
                  }).whenComplete(() {
                    ctrl.clear();
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
