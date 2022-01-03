import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypted_messaging/main.dart';
import 'package:encrypted_messaging/models/chat_model.dart';
import 'package:encrypted_messaging/models/message_model.dart';
import 'package:encrypted_messaging/models/user_model.dart';
import 'package:encrypted_messaging/screens/chat/chat.dart';
import 'package:encrypted_messaging/screens/contacts/contacts.dart';
import 'package:encrypted_messaging/services/auth/i_auth_service.dart';
import 'package:encrypted_messaging/services/data/i_firestore_db.dart';
import 'package:encrypted_messaging/services/encryption/i_encryption_service.dart';
import 'package:encrypted_messaging/services/providers/providers.dart';
import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'appbar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference<Map<String, dynamic>> ref =
      FirebaseFirestore.instance.collection(Vars.chatsCol);

  List<String>? myPrefs;

  bool isLoad = true;

  Future getMyPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Hive.openBox<UserModel>(Vars.userBox);

    setState(() {
      myPrefs = prefs.getStringList(Vars.userPreferences);
      isLoad = false;
    });
  }

  @override
  void initState() {
    getMyPrefs();
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: s.width,
        height: s.height,
        color: Clr.grayBg,
        child: isLoad
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Container(
                    width: s.width,
                    height: s.height,
                    padding: EdgeInsets.only(top: hh(context, 112)),
                    child: StreamBuilder(
                      stream: ref
                          .where('members', arrayContains: myPrefs![0])
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        var data = snapshot.data;
                        if (data != null) {
                          if (data.docs.isNotEmpty) {
                            var userBox = Hive.box<UserModel>(Vars.userBox);
                            return ChatList(
                                data: data, myPrefs: myPrefs, userBox: userBox);
                          }
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                  HAppbar(onTap: () async {
                    final _auth = IAuthService();
                    await _auth.signOut().whenComplete(() {
                      Routing.pushRep(context, Wrapper());
                    });
                  }),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Routing.push(context, Contacts(myPrefs: myPrefs));
        },
        child: SvgPicture.asset(
          "assets/icons/MessageBubble.svg",
          width: ww(context, 26),
        ),
      ),
    );
  }
}

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
    Size s = MediaQuery.of(context).size;
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
