import 'package:encrypted_messaging/models/bottom_icon_model.dart';
import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:flutter/material.dart';

class BottomIconItem extends StatelessWidget {
  const BottomIconItem({
    Key? key,
    required this.isActive,
    required this.icon,
    this.onTap,
  }) : super(key: key);
  final bool isActive;
  final BottomIconModel icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var iconData = isActive ? icon.iconActive : icon.iconPassive;
    return Material(
      borderRadius: BorderRadius.circular(hh(context, 8)),
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(hh(context, 8)),
        child: Container(
          width: hh(context, 44),
          height: hh(context, 44),
          padding: EdgeInsets.all(hh(context, 4)),
          child: Icon(
            iconData,
            color: isActive ? Clr.blue : Clr.black800,
          ),
        ),
      ),
    );
  }
}
