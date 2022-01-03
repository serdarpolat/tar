import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:flutter/material.dart';

import 'sender_widgets.dart';

class Sender extends StatefulWidget {
  final TextEditingController msgCtrl;
  final Function()? onTap;

  const Sender({Key? key, required this.msgCtrl, required this.onTap})
      : super(key: key);
  @override
  _SenderState createState() => _SenderState();
}

class _SenderState extends State<Sender> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: s.width,
        height: hh(context, 86),
        color: Clr.white,
        child: Padding(
          padding: EdgeInsets.only(left: ww(context, 16)),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: hh(context, 54),
                  padding: EdgeInsets.all(ww(context, 10)),
                  child: Row(
                    children: [
                      messageInput(
                        context,
                        msgCtrl: widget.msgCtrl,
                      ),
                      addMedya(context),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ww(context, 8)),
                    border: Border.all(
                      color: Clr.textLight,
                      width: hh(context, 1),
                    ),
                  ),
                ),
              ),
              SizedBox(width: ww(context, 10)),
              sendButton(
                context,
                msgCtrl: widget.msgCtrl,
                onTap: widget.onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
