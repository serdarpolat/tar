import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypted_messaging/models/chat_model.dart';
import 'package:encrypted_messaging/models/user_model.dart';
import 'package:encrypted_messaging/services/data/i_firestore_db.dart';
import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatItem extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> e;
  final UserModel userModel;
  final List<String>? myPrefs;

  const ChatItem(
      {Key? key,
      required this.e,
      required this.userModel,
      required this.myPrefs})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(Vars.chatsCol)
          .doc(e.id)
          .collection(Vars.msgCol)
          .orderBy('senttime')
          .snapshots(),
      builder: (_, AsyncSnapshot<QuerySnapshot> msgSnap) {
        var msgData = msgSnap.data;

        if (msgData != null) {
          if (msgData.docs.isNotEmpty) {
            int unreadCount = 0;
            msgData.docs.forEach((element) {
              if (element['status'] == 'unread') unreadCount += 1;
            });

            final _dataService = IFirestoreDb();

            ChatModel chatModel = _dataService.getChatModel(
                msgData, userModel, myPrefs, unreadCount);

            DateTime dateTime = chatModel.time.toDate();

            String time =
                dateTime.hour.toString() + ":" + dateTime.minute.toString();

            return Container(
              width: s.width,
              padding: EdgeInsets.symmetric(
                  horizontal: ww(context, 16), vertical: hh(context, 8)),
              color: Clr.white,
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  chatModel.name,
                  style: TextStyle(
                    color: Clr.text,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(chatModel.lastMsg),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(ww(context, 36)),
                  child: Container(
                    width: ww(context, 36),
                    height: ww(context, 36),
                    child: SvgPicture.asset(
                      "assets/images/user/${chatModel.img}",
                    ),
                  ),
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      time,
                      style: TextStyle(color: Clr.textLight),
                    ),
                    Container(
                      width: ww(context, 18),
                      height: ww(context, 18),
                      child: Center(
                        child: Text(
                          chatModel.unreadCount.toString(),
                          style: TextStyle(
                            fontSize: ww(context, 12),
                            height: 1.25,
                            color: chatModel.unreadCount > 0
                                ? Clr.white
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: chatModel.unreadCount > 0
                            ? Clr.green
                            : Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }

        return Container();
      },
    );
  }
}
