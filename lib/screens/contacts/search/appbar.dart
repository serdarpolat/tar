import 'package:encrypted_messaging/services/providers/providers.dart';
import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Container(
      width: s.width,
      height: hh(context, 140),
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
      padding: EdgeInsets.only(top: hh(context, 44)),
      child: Column(
        children: [
          searchAppbarTop(context),
          SizedBox(height: hh(context, 6)),
          searchAppbarBottom(context, s),
        ],
      ),
    );
  }
}

Widget searchAppbarBottom(BuildContext context, Size s) => Expanded(
      child: Container(
        width: s.width,
        padding: EdgeInsets.symmetric(
            horizontal: ww(context, 16), vertical: hh(context, 8)),
        child: Container(
          decoration: BoxDecoration(
            color: Clr.grayBg,
            borderRadius: BorderRadius.circular(ww(context, 30)),
          ),
          padding: EdgeInsets.symmetric(horizontal: ww(context, 12)),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.name,
                  onChanged: (input) {
                    final query =
                        Provider.of<SearchQuery>(context, listen: false);
                    query.changeSearchTitle(input.trim());
                    print(query.title);
                  },
                  decoration: InputDecoration(
                    hintText: "Seacrh to find...",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SvgPicture.asset(
                "assets/icons/Search.svg",
                height: hh(context, 24),
              ),
            ],
          ),
        ),
      ),
    );

Widget searchAppbarTop(BuildContext context) => paddingHorizontal(
      context,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              "Search Contact",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Clr.text,
              ),
            ),
          ),
        ],
      ),
    );
