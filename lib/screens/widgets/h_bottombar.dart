import 'package:encrypted_messaging/models/bottom_icon_model.dart';
import 'package:encrypted_messaging/screens/contacts/contacts.dart';
import 'package:encrypted_messaging/screens/contacts/search/search.dart';
import 'package:encrypted_messaging/screens/home/home.dart';
import 'package:encrypted_messaging/screens/widgets/bottom_icon_item.dart';
import 'package:encrypted_messaging/services/providers/providers.dart';
import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HBottombar extends StatelessWidget {
  const HBottombar({
    Key? key,
    required this.page,
    this.myPrefs,
  }) : super(key: key);
  final int page;
  final List<String>? myPrefs;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        height: hh(context, 64),
        color: Clr.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BottomIconItem(
              isActive: page == 0,
              icon: bottomIcons[0],
              onTap: () {
                final query = Provider.of<SearchQuery>(context, listen: false);
                query.changeSearchTitle("");
                if (page != 0) Routing.pushRep(context, Home());
              },
            ),
            BottomIconItem(
              isActive: page == 1,
              icon: bottomIcons[1],
              onTap: () {
                final query = Provider.of<SearchQuery>(context, listen: false);
                query.changeSearchTitle("");
                if (page != 1) Routing.pushRep(context, Contacts());
              },
            ),
            BottomIconItem(
              isActive: page == 2,
              icon: bottomIcons[2],
              onTap: () {
                final query = Provider.of<SearchQuery>(context, listen: false);
                query.changeSearchTitle("");
                if (page != 2)
                  Routing.pushRep(
                    context,
                    Search(
                      myPrefs: myPrefs,
                    ),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}
