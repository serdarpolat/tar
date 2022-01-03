import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypted_messaging/models/user_model.dart';
import 'package:encrypted_messaging/screens/profile/profile.dart';
import 'package:encrypted_messaging/screens/widgets/chat_list.dart';
import 'package:encrypted_messaging/screens/widgets/h_bottombar.dart';
import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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
                        if (snapshot.hasData) {
                          var data = snapshot.data;
                          if (data!.size > 0) {
                            var userBox = Hive.box<UserModel>(Vars.userBox);
                            return ChatList(
                                data: data, myPrefs: myPrefs, userBox: userBox);
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "🤷",
                                  style: TextStyle(
                                    fontSize: hh(context, 48),
                                  ),
                                ),
                                SizedBox(
                                  height: hh(context, 12),
                                ),
                                Text(
                                  "You have not started a chat yet.",
                                  style: TextStyle(
                                    fontSize: hh(context, 18),
                                    fontWeight: FontWeight.w500,
                                    color: Clr.black,
                                  ),
                                ),
                              ],
                            );
                          }
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  HAppbar(
                    myPrefs: myPrefs,
                    onTap: () async {
                      Routing.push(
                        context,
                        Profile(
                          myPrefs: myPrefs,
                        ),
                      );
                    },
                  ),
                  HBottombar(
                    page: 0,
                    myPrefs: myPrefs,
                  ),
                ],
              ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Routing.push(context, Contacts(myPrefs: myPrefs));
      //   },
      //   child: SvgPicture.asset(
      //     "assets/icons/MessageBubble.svg",
      //     width: ww(context, 26),
      //   ),
      // ),
    );
  }
}
