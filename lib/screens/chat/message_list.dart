import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypted_messaging/services/encryption/i_encryption_service.dart';
import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:flutter/material.dart';

class MessageList extends StatelessWidget {
  final List<QueryDocumentSnapshot<Object?>> docs;
  final String myUid;
  final String myPrivKey;
  const MessageList({
    Key? key,
    required this.docs,
    required this.myUid,
    required this.myPrivKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return ListView(
      physics: BouncingScrollPhysics(),
      reverse: true,
      padding: EdgeInsets.symmetric(vertical: hh(context, 6)),
      children: docs.map((e) {
        bool isRight = e['senderId'] == myUid;
        return MessageListItem(
          s: s,
          isRight: isRight,
          e: e,
          myPrivKey: this.myPrivKey,
        );
      }).toList(),
    );
  }
}

class MessageListItem extends StatelessWidget {
  final Size s;
  final bool isRight;
  final QueryDocumentSnapshot<Object?> e;
  final String myPrivKey;
  const MessageListItem({
    Key? key,
    required this.s,
    required this.isRight,
    required this.e,
    required this.myPrivKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IEncryptionService _encService = IEncryptionService();
    return Container(
      width: s.width,
      padding: EdgeInsets.only(bottom: hh(context, 6), top: hh(context, 6)),
      child: paddingHorizontal(
        context,
        child: Row(
          mainAxisAlignment:
              isRight ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              child: Text(
                _encService.decrypt(myPrivKey, e['message']),
                textAlign: isRight ? TextAlign.right : TextAlign.left,
                style: TextStyle(
                  color: isRight ? Clr.white : Clr.text,
                  fontSize: hh(context, 14),
                  fontWeight: FontWeight.w500,
                ),
              ),
              constraints: BoxConstraints(maxWidth: s.width * 0.75),
              padding: EdgeInsets.symmetric(
                  vertical: hh(context, 10), horizontal: ww(context, 16)),
              decoration: BoxDecoration(
                color: isRight ? Clr.blue : Clr.white,
                boxShadow: [
                  BoxShadow(
                    color: Clr.textLight.withOpacity(0.5),
                    offset: Offset(0, hh(context, 3)),
                    blurRadius: hh(context, 6),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: isRight
                      ? Radius.circular(ww(context, 16))
                      : Radius.circular(0),
                  topRight: isRight
                      ? Radius.circular(0)
                      : Radius.circular(ww(context, 16)),
                  bottomLeft: Radius.circular(ww(context, 16)),
                  bottomRight: Radius.circular(ww(context, 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
