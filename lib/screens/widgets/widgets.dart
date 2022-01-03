import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:flutter/material.dart';

Widget textField(
  BuildContext context,
  Size s, {
  required double width,
  required TextEditingController ctrl,
  required String hintText,
  TextInputType? keyboardType = TextInputType.text,
  bool obscureText = false,
}) =>
    Container(
      width: width,
      child: TextFormField(
        controller: ctrl,
        validator: (value) {
          if (value == null || value.length < 3) {
            return 'Enter $hintText';
          }
          return null;
        },
        style: TextStyle(
          fontSize: hh(context, 14),
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Clr.textLight,
            fontSize: hh(context, 14),
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Clr.textLight,
              width: hh(context, 1),
            ),
            borderRadius: BorderRadius.circular(hh(context, 8)),
          ),
        ),
      ),
    );

class CustomAuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color bgColor;
  final Widget child;

  CustomAuthButton(
      {required this.onPressed, this.bgColor = Clr.blue, required this.child});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return paddingHorizontal(
      context,
      child: MaterialButton(
        onPressed: onPressed,
        color: bgColor,
        minWidth: s.width,
        elevation: 1,
        height: hh(context, 60),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(hh(context, 8))),
        child: child,
      ),
    );
  }
}

Widget customButton(BuildContext context, Size s,
        {required Widget child,
        required VoidCallback onPressed,
        Color bgColor = Clr.blue}) =>
    paddingHorizontal(
      context,
      child: MaterialButton(
        onPressed: onPressed,
        color: bgColor,
        minWidth: s.width,
        elevation: 1,
        height: hh(context, 60),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(hh(context, 8))),
        child: child,
      ),
    );
