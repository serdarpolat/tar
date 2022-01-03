import 'package:encrypted_messaging/services/providers/providers.dart';
import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'login_form.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: s.width,
        height: s.height,
        color: Clr.grayBg,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: hh(context, 120)),
              Container(
                height: 120,
                child: SvgPicture.asset(
                  "assets/icons/BrandLogoDark.svg",
                ),
              ),
              SizedBox(height: hh(context, 120)),
              LoginForm(),
              SizedBox(height: hh(context, 24)),
              Column(
                children: [
                  Text(
                    "Don't have account?",
                    style: TextStyle(
                      color: Clr.text,
                      fontSize: hh(context, 14),
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      final isLogin =
                          Provider.of<IsLoginPage>(context, listen: false);
                      isLogin.changeLoginState();
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Clr.blue,
                        fontSize: hh(context, 14),
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
