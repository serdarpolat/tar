import 'dart:math';

import 'package:encrypted_messaging/main.dart';
import 'package:encrypted_messaging/models/user_model.dart';
import 'package:encrypted_messaging/screens/widgets/widgets.dart';
import 'package:encrypted_messaging/services/auth/i_auth_service.dart';
import 'package:encrypted_messaging/services/data/i_firestore_db.dart';
import 'package:encrypted_messaging/services/providers/providers.dart';
import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:encryption/encryption.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  TextEditingController passAgainCtrl = TextEditingController();
  TextEditingController fNameCtrl = TextEditingController();
  TextEditingController lNameCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    passAgainCtrl.dispose();
    fNameCtrl.dispose();
    lNameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          paddingHorizontal(
            context,
            child: Row(
              children: [
                textField(
                  context,
                  s,
                  width: (s.width - ww(context, 44)) / 2,
                  ctrl: fNameCtrl,
                  hintText: "First Name",
                  keyboardType: TextInputType.name,
                ),
                Spacer(),
                textField(
                  context,
                  s,
                  width: (s.width - ww(context, 44)) / 2,
                  ctrl: lNameCtrl,
                  hintText: "Last Name",
                  keyboardType: TextInputType.name,
                ),
              ],
            ),
          ),
          SizedBox(height: hh(context, 18)),
          textField(
            context,
            s,
            width: s.width - ww(context, 32),
            ctrl: emailCtrl,
            hintText: "Email Address",
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: hh(context, 18)),
          textField(
            context,
            s,
            width: s.width - ww(context, 32),
            ctrl: passCtrl,
            hintText: "Password",
            keyboardType: TextInputType.text,
            obscureText: true,
          ),
          SizedBox(height: hh(context, 18)),
          textField(
            context,
            s,
            width: s.width - ww(context, 32),
            ctrl: passAgainCtrl,
            hintText: "Password Again",
            keyboardType: TextInputType.text,
            obscureText: true,
          ),
          SizedBox(height: hh(context, 48)),
          Consumer(
            builder:
                (BuildContext context, LoadingState loading, Widget? child) {
              return CustomAuthButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    print(1);
                    loading.changeLoadingState(true);

                    final _auth = IAuthService();
                    final _db = IFirestoreDb();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    RSAKeypair keyPair = RSAKeypair.fromRandom();

                    await _auth
                        .register(emailCtrl.text.trim(), passCtrl.text.trim())
                        .then((result) async {
                      print(2);
                      if (result != "" && result != "email") {
                        String privateKey = keyPair.privateKey.toString();
                        String publicKey = keyPair.publicKey.toString();

                        UserModel userModel = UserModel(
                          uid: result,
                          fName: fNameCtrl.text.trim(),
                          lName: lNameCtrl.text.trim(),
                          isActive: true,
                          photoUrl:
                              (Random().nextInt(10) + 1).toString() + ".svg",
                          publicKey: publicKey,
                        );

                        await _db.addUser(userModel).then((res) async {
                          print(3);
                          print(4);
                          await prefs.setStringList(Vars.userPreferences, [
                            result,
                            userModel.fName,
                            userModel.lName,
                            userModel.isActive.toString(),
                            userModel.photoUrl,
                            userModel.publicKey,
                            privateKey,
                          ]).then((value) {
                            print(5);
                            if (value) {
                              print(6);

                              loading.changeLoadingState(false);
                              Routing.pushRep(context, Wrapper());
                            }
                          });
                        });
                      }
                    });
                  }
                },
                child: loading.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Clr.white,
                        ),
                      )
                    : Text(
                        "Register",
                        style: TextStyle(
                          color: Clr.white,
                          fontSize: hh(context, 16),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
