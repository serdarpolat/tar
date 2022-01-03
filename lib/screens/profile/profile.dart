import 'package:encrypted_messaging/main.dart';
import 'package:encrypted_messaging/models/user_model.dart';
import 'package:encrypted_messaging/screens/widgets/widgets.dart';
import 'package:encrypted_messaging/services/auth/i_auth_service.dart';
import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  final List<String>? myPrefs;

  const Profile({Key? key, this.myPrefs}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Box<UserModel>? usersBox;
  UserModel? profile;
  List<String>? userData;
  bool loading = true;
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController msgCtrl = TextEditingController();

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userData = prefs.getStringList(Vars.userPreferences);
      profile = UserModel(
        uid: userData![0],
        fName: userData![1],
        lName: userData![2],
        isActive: userData![3] == "true" ? true : false,
        photoUrl: userData![4],
        publicKey: userData![5],
      );
      loading = false;
    });
  }

  @override
  void initState() {
    getUserData();
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
    if (profile != null) {
      nameCtrl.text = profile!.fName + " " + profile!.lName;
    }
    msgCtrl.text = "Today is better day!";
    return Scaffold(
      body: Container(
        width: s.width,
        height: s.height,
        color: Clr.grayBg,
        child: Stack(
          children: [
            if (loading)
              Center(
                child: CircularProgressIndicator(),
              ),
            if (!loading)
              Container(
                width: s.width,
                height: s.height,
                color: Clr.grayBg,
                padding: EdgeInsets.only(top: hh(context, 112)),
                child: Column(
                  children: [
                    SizedBox(
                      height: hh(context, 50),
                    ),
                    Container(
                      child: ClipOval(
                        child: SvgPicture.asset(
                          "assets/images/user/${profile!.photoUrl}",
                          width: ww(context, 190),
                        ),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: ww(context, 3),
                          color: Clr.blue,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: hh(context, 50),
                    ),
                    textField(
                      context,
                      s,
                      width: s.width - ww(context, 56),
                      ctrl: nameCtrl,
                      hintText: profile!.fName + " " + profile!.lName,
                    ),
                    SizedBox(
                      height: hh(context, 18),
                    ),
                    textField(
                      context,
                      s,
                      width: s.width - ww(context, 56),
                      ctrl: msgCtrl,
                      hintText: "",
                    ),
                    SizedBox(
                      height: hh(context, 50),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        final _auth = IAuthService();

                        await _auth.signOut().whenComplete(() {
                          Routing.pushRep(context, Wrapper());
                        });
                      },
                      elevation: 0,
                      focusElevation: 0,
                      hoverElevation: 0,
                      height: hh(context, 54),
                      highlightElevation: 0,
                      minWidth: s.width - 56,
                      child: Text(
                        "Logout".toUpperCase(),
                        style: TextStyle(
                          color: Clr.red,
                          fontWeight: FontWeight.w800,
                          fontSize: hh(context, 16),
                          height: 1,
                          letterSpacing: 1.2,
                        ),
                      ),
                      color: Clr.red.withOpacity(0.1),
                    ),
                  ],
                ),
              ),
            PAppbar(),
          ],
        ),
      ),
      // floatingActionButton: toggle.del
      //     ? Container()
      //     : FloatingActionButton(
      //         onPressed: () {
      //           Routing.push(context, Search(myPrefs: widget.myPrefs));
      //         },
      //         backgroundColor: Clr.blue,
      //         child: Icon(Icons.add),
      //       ),
    );
  }
}

class PAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Container(
      width: s.width,
      height: hh(context, 100),
      decoration: BoxDecoration(
        color: Clr.white,
        boxShadow: [
          BoxShadow(
            color: Clr.textLight.withOpacity(0.3),
            offset: Offset(0, hh(context, 4)),
            blurRadius: hh(context, 8),
          ),
        ],
      ),
      padding: EdgeInsets.only(top: hh(context, 44), bottom: hh(context, 6)),
      child: paddingHorizontal(
        context,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: ww(context, 74),
                child: Row(
                  children: [
                    Container(
                      width: ww(context, 30),
                      height: ww(context, 30),
                      padding: EdgeInsets.all(ww(context, 3)),
                      child: SvgPicture.asset(
                        "assets/icons/ArrowBack.svg",
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Clr.lightBlue,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Back",
                      style: TextStyle(
                        fontSize: hh(context, 16),
                        fontWeight: FontWeight.w700,
                        color: Clr.blue,
                        height: 1.18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Text(
                "Profile",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Clr.text,
                ),
              ),
            ),
            Container(
              width: ww(context, 74),
            ),
          ],
        ),
      ),
    );
  }
}
