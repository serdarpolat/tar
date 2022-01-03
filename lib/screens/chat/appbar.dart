import 'package:encrypted_messaging/models/user_model.dart';
import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CAppbar extends StatelessWidget {
  final UserModel user;

  const CAppbar({Key? key, required this.user}) : super(key: key);
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
                Routing.pop(context);
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
              width: ww(context, 30),
              height: ww(context, 30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(ww(context, 30)),
                    child: SvgPicture.asset(
                      "assets/images/user/${user.photoUrl}",
                      width: ww(context, 30),
                      height: ww(context, 30),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: ww(context, 8),
                      height: ww(context, 8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Clr.green,
                        border: Border.all(
                          color: Clr.white,
                          width: ww(context, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: ww(context, 74),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.call,
                    color: Clr.blue,
                  ),
                  SizedBox(width: ww(context, 12)),
                  Icon(
                    Icons.info_outline,
                    color: Clr.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
