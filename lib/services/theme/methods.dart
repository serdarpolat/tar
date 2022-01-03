import 'package:flutter/cupertino.dart';

double ww(BuildContext context, double size) {
  return size * MediaQuery.of(context).size.width / 375;
}

double hh(BuildContext context, double size) {
  return size * MediaQuery.of(context).size.height / 812;
}

Padding paddingHorizontal(BuildContext context, {Widget? child}) => Padding(
      padding: EdgeInsets.symmetric(horizontal: ww(context, 16)),
      child: child,
    );
