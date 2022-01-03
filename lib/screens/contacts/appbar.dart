import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:flutter/material.dart';

class CAppbar extends StatelessWidget {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "Contacts",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Clr.text,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
