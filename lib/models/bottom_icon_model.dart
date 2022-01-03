import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BottomIconModel {
  final int id;
  final IconData iconActive;
  final IconData iconPassive;

  BottomIconModel(this.id, this.iconActive, this.iconPassive);
}

List<BottomIconModel> bottomIcons = [
  BottomIconModel(
    0,
    Ionicons.chatbubbles,
    Ionicons.chatbubbles_outline,
  ),
  BottomIconModel(
    1,
    Ionicons.people,
    Ionicons.people_outline,
  ),
  BottomIconModel(
    2,
    Ionicons.search,
    Ionicons.search_outline,
  ),
];
