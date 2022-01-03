import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypted_messaging/models/chat_model.dart';
import 'package:encrypted_messaging/models/message_model.dart';
import 'package:encrypted_messaging/models/user_model.dart';
import 'package:encrypted_messaging/services/encryption/i_encryption_service.dart';
import 'package:encrypted_messaging/services/theme/variables.dart';

class FirestoreDb {
  final _firestore = FirebaseFirestore.instance;

  Future<String> addUser(UserModel user) async {
    var value = await _firestore.collection(Vars.usersCol).add(user.toMap());

    return value.id;
  }

  Future<UserModel> getUserFromChat(List<dynamic> members, String myUid) async {
    String userId = members[members.indexWhere((el) => el != myUid)];

    var data = await _firestore
        .collection(Vars.usersCol)
        .where('uid', isEqualTo: userId)
        .get();

    UserModel user = UserModel.fromSnapshot(data.docs.first);

    return user;
  }

  Future<UserModel> getUserByUid(String myUid) async {
    var data = await _firestore
        .collection(Vars.usersCol)
        .where('uid', isEqualTo: myUid)
        .get();
    UserModel user = UserModel.fromSnapshot(data.docs.first);

    return user;
  }

  Stream<List<UserModel>> getUserByName(String query) {
    var data =
        _firestore.collection(Vars.usersCol).where('fName', isEqualTo: query);

    return data.snapshots().map(
        (event) => event.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  Future<List<MessageModel>> getMessages(String chatUid) async {
    var res = await _firestore
        .collection(Vars.chatsCol)
        .doc(chatUid)
        .collection(Vars.msgCol)
        .orderBy('senttime')
        .get();

    List<MessageModel> messages =
        res.docs.map((e) => MessageModel.fromSnapshot(e)).toList();

    return messages;
  }

  Future<String> createChat(List<String> ids) async {
    var res = await _firestore.collection(Vars.chatsCol).add({'members': ids});

    return res.id;
  }

  ChatModel getChatModel(QuerySnapshot<Object?>? msgData, UserModel userModel,
      List<String>? myPrefs, int unreadCount) {
    final _encService = IEncryptionService();
    ChatModel? chatModel;
    if (msgData!.docs.first['senderId'] == userModel.uid) {
      chatModel = ChatModel(
          img: userModel.photoUrl,
          name: userModel.fName + " " + userModel.lName,
          lastMsg: _encService.decrypt(
              myPrefs![6], msgData.docs.first['message'][0]),
          time: msgData.docs.first['senttime'],
          unreadCount: unreadCount);
    } else {
      chatModel = ChatModel(
          img: userModel.photoUrl,
          name: userModel.fName + " " + userModel.lName,
          lastMsg: _encService.decrypt(
              myPrefs![6], msgData.docs.first['message'][1]),
          time: msgData.docs.first['senttime'],
          unreadCount: 0);
    }

    return chatModel;
  }
}
