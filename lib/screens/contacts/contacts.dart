import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypted_messaging/models/user_model.dart';
import 'package:encrypted_messaging/screens/auth/widgets.dart';
import 'package:encrypted_messaging/screens/chat/chat.dart';
import 'package:encrypted_messaging/services/data/i_firestore_db.dart';
import 'package:encrypted_messaging/services/providers/providers.dart';
import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'appbar.dart';
import 'search/search.dart';

class Contacts extends StatefulWidget {
  final List<String>? myPrefs;

  const Contacts({Key? key, this.myPrefs}) : super(key: key);
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  Box<UserModel>? usersBox;
  bool loading = true;
  openBox() async {
    usersBox = await Hive.openBox<UserModel>(Vars.userBox).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    openBox();
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
    return Consumer(builder: (_, DeleteContact toggle, Widget? child) {
      return Scaffold(
        body: Container(
          width: s.width,
          height: s.height,
          color: Clr.grayBg,
          child: Stack(
            children: [
              Container(
                width: s.width,
                height: s.height,
                color: Clr.grayBg,
                padding: EdgeInsets.only(top: hh(context, 112)),
                child: loading
                    ? Center(child: Text("Loading..."))
                    : usersBox!.length > 0
                        ? ContactsList(
                            box: usersBox!,
                            myPrefs: widget.myPrefs!,
                          )
                        : Center(child: Text("No Data")),
              ),
              CAppbar(),
              Consumer(builder: (_, DeleteContact toggle, Widget? child) {
                return DeleteContactAlert(
                  isOpen: toggle.del,
                );
              }),
            ],
          ),
        ),
        floatingActionButton: toggle.del
            ? Container()
            : FloatingActionButton(
                onPressed: () {
                  Routing.push(context, Search(myPrefs: widget.myPrefs));
                },
                backgroundColor: Clr.blue,
                child: Icon(Icons.add),
              ),
      );
    });
  }
}

class DeleteContactAlert extends StatelessWidget {
  final bool isOpen;
  const DeleteContactAlert({Key? key, required this.isOpen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return AnimatedPositioned(
      duration: Duration(milliseconds: 240),
      left: 0,
      top: isOpen ? 0 : s.height,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: ww(context, 15),
            sigmaY: ww(context, 15),
          ),
          child: Container(
            width: s.width,
            height: s.height,
            color: Clr.textLight.withOpacity(0.1),
            child: Center(
              child: Container(
                width: s.width * 0.8,
                height: (s.width * 0.8) * 3 / 4,
                padding: EdgeInsets.all(ww(context, 24)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Are you sure you want to delete this contact?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Clr.text,
                        fontSize: hh(context, 18),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "😢",
                      style: TextStyle(
                        fontSize: hh(context, 42),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            final toggle = Provider.of<DeleteContact>(context,
                                listen: false);
                            toggle.toggleDel();
                          },
                          color: Clr.blue,
                          elevation: 1,
                          height: hh(context, 36),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(hh(context, 8))),
                          child: Text(
                            "No",
                            style: TextStyle(
                              color: Clr.white,
                              fontSize: hh(context, 16),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            final toggle = Provider.of<DeleteContact>(context,
                                listen: false);
                            toggle.toggleDel();
                          },
                          color: Clr.blue,
                          elevation: 1,
                          height: hh(context, 36),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(hh(context, 8))),
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              color: Clr.white,
                              fontSize: hh(context, 16),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Clr.white,
                  borderRadius: BorderRadius.circular(ww(context, 16)),
                  boxShadow: [
                    BoxShadow(
                      color: Clr.textLight.withOpacity(0.25),
                      offset: Offset(0, hh(context, 8)),
                      blurRadius: hh(context, 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContactsList extends StatelessWidget {
  final Box<UserModel> box;
  final List<String> myPrefs;
  const ContactsList({Key? key, required this.box, required this.myPrefs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    IFirestoreDb _db = IFirestoreDb();
    return ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: box.length,
        itemBuilder: (_, index) {
          UserModel u = box.getAt(index)!;
          return Container(
            width: MediaQuery.of(context).size.width,
            color: Clr.white,
            child: ListTile(
              onLongPress: () {
                final toggle =
                    Provider.of<DeleteContact>(context, listen: false);
                toggle.toggleDel();
              },
              onTap: () async {
                print("User Uid : " + u.uid);
                print("My Uid : " + myPrefs[0]);

                await FirebaseFirestore.instance
                    .collection(Vars.chatsCol)
                    .where('members', isEqualTo: [u.uid, myPrefs[0]])
                    .get()
                    .then((val) async {
                      if (val.docs.length > 0) {
                        print(true);
                        Routing.push(
                            context,
                            Chat(
                              chatId: val.docs.first.id,
                              user: u,
                              myPrefs: myPrefs,
                            ));
                      } else {
                        await _db
                            .createChat([u.uid, myPrefs[0]]).then((id) async {
                          Routing.push(
                              context,
                              Chat(
                                chatId: id,
                                user: u,
                                myPrefs: myPrefs,
                              ));
                        });
                      }
                    });
              },
              title: Text(
                u.fName + " " + u.lName,
                style: TextStyle(
                  color: Clr.text,
                  fontWeight: FontWeight.w600,
                  fontSize: hh(context, 16),
                ),
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(ww(context, 36)),
                child: Container(
                  width: ww(context, 36),
                  height: ww(context, 36),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Clr.lightBlue,
                        width: hh(context, 0.5),
                      ),
                    ),
                  ),
                  child: SvgPicture.asset("assets/images/user/${u.photoUrl}"),
                ),
              ),
              trailing: MaterialButton(
                onPressed: () async {
                  print(u.uid);
                },
                shape: CircleBorder(),
                child: SvgPicture.asset(
                  "assets/icons/MessageBubble.svg",
                  width: ww(context, 18),
                  color: Clr.white,
                ),
                color: Clr.blue,
              ),
            ),
          );
        });
  }
}
