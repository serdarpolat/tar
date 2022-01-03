import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HAppbar extends StatelessWidget {
  final VoidCallback onTap;

  const HAppbar({Key? key, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Container(
      width: s.width,
      padding: EdgeInsets.only(top: hh(context, 44), bottom: hh(context, 6)),
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
      child: paddingHorizontal(
        context,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Chats",
              style: TextStyle(
                color: Clr.text,
                fontSize: hh(context, 32),
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: ww(context, 40),
                height: ww(context, 40),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(ww(context, 40)),
                      child: SvgPicture.asset("assets/images/user/1.svg"),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: ww(context, 12),
                        height: ww(context, 12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Clr.green,
                          border: Border.all(
                            color: Clr.white,
                            width: ww(context, 1.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
