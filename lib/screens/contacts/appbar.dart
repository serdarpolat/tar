import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                "Contacts",
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
