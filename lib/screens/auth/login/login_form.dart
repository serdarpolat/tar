import 'package:encrypted_messaging/main.dart';
import 'package:encrypted_messaging/screens/widgets/widgets.dart';
import 'package:encrypted_messaging/services/auth/i_auth_service.dart';
import 'package:encrypted_messaging/services/providers/providers.dart';
import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
          ),
          SizedBox(height: hh(context, 48)),
          Consumer(builder:
              (BuildContext context, LoadingState loading, Widget? child) {
            return CustomAuthButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  loading.changeLoadingState(true);
                  print("ok");
                  final _auth = IAuthService();
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  await _auth
                      .signIn(
                    emailCtrl.text,
                    passCtrl.text,
                  )
                      .then((value) async {
                    print(1);
                    if (value == "wrong" || value == "not" || value == "") {
                      print(2);
                      print("wrong");
                    }

                    var userPrefs = prefs.getStringList(Vars.userPreferences);

                    if (userPrefs![0] == value) {
                      print(3);
                      loading.changeLoadingState(false);
                      Routing.pushRep(context, Wrapper());
                    }
                  });
                }
              },
              child: Text(
                "Login",
                style: TextStyle(
                  color: Clr.white,
                  fontSize: hh(context, 16),
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
