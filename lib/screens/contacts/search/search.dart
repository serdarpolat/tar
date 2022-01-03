import 'package:encrypted_messaging/models/user_model.dart';
import 'package:encrypted_messaging/screens/widgets/h_bottombar.dart';
import 'package:encrypted_messaging/services/data/i_firestore_db.dart';
import 'package:encrypted_messaging/services/providers/providers.dart';
import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'appbar.dart';

class Search extends StatefulWidget {
  final List<String>? myPrefs;

  const Search({Key? key, required this.myPrefs}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  IFirestoreDb _db = IFirestoreDb();

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
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
              padding: EdgeInsets.only(top: hh(context, 152)),
              child: Consumer(builder:
                  (BuildContext context, SearchQuery query, Widget? child) {
                if (query.title.length < 3) return Text("No Contact");

                return StreamBuilder(
                    stream: _db.getUserByName(query.title),
                    builder: (_, AsyncSnapshot<List<UserModel>> snap) {
                      var data = snap.data;
                      if (data == null) {
                        return Text("Data is null");
                      }

                      if (data.length == 0) {
                        return Text("Data is Empty");
                      }

                      return ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemCount: data.length,
                          itemBuilder: (_, index) {
                            var u = data[index];
                            return Container(
                              width: s.width,
                              color: Clr.white,
                              child: ListTile(
                                title: Text(
                                  u.fName + " " + u.lName,
                                  style: TextStyle(
                                    color: Clr.text,
                                    fontWeight: FontWeight.w600,
                                    fontSize: hh(context, 16),
                                  ),
                                ),
                                leading: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(ww(context, 36)),
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
                                    child: SvgPicture.asset(
                                        "assets/images/user/${u.photoUrl}"),
                                  ),
                                ),
                                trailing: MaterialButton(
                                  onPressed: () async {
                                    var box = await Hive.openBox<UserModel>(
                                        Vars.userBox);

                                    await box.put(u.uid, u).whenComplete(() {
                                      query.changeSearchTitle("");
                                      Routing.pop(context);
                                    });
                                  },
                                  shape: StadiumBorder(),
                                  child: Text(
                                    "Add",
                                    style: TextStyle(
                                      color: Clr.white,
                                      fontSize: hh(context, 12),
                                    ),
                                  ),
                                  color: Clr.blue,
                                ),
                              ),
                            );
                          });
                    });
              }),
            ),
            SAppbar(),
            HBottombar(
              page: 2,
              myPrefs: widget.myPrefs,
            ),
          ],
        ),
      ),
    );
  }
}
