import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget sendButton(
  BuildContext context, {
  required TextEditingController msgCtrl,
  Function()? onTap,
}) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
        width: ww(context, 46),
        height: ww(context, 46),
        margin: EdgeInsets.only(right: ww(context, 16)),
        child: Center(
          child: SvgPicture.asset(
            "assets/icons/Send.svg",
            color: Clr.white,
            width: ww(context, 24),
          ),
        ),
        decoration: BoxDecoration(
          color: Clr.blue,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Clr.black.withOpacity(0.2),
              offset: Offset(0, hh(context, 4)),
              blurRadius: hh(context, 8),
            ),
          ],
        ),
      ),
    );

Widget addMedya(BuildContext context) => Container(
      child: Icon(Icons.add, color: Clr.text),
      padding: EdgeInsets.all(ww(context, 6)),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Clr.textLight,
      ),
    );

Widget messageInput(
  BuildContext context, {
  required TextEditingController msgCtrl,
  Function(String)? onChanged,
}) =>
    Expanded(
      child: Container(
        child: TextField(
          controller: msgCtrl,
          onChanged: onChanged,
          maxLines: 5,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            hintText: "Message",
            hintStyle: TextStyle(
              fontSize: hh(context, 14),
              fontWeight: FontWeight.w500,
              color: Clr.textLight,
              height: 1.21,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
