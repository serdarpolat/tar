import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypted_messaging/models/chat_model.dart';
import 'package:encrypted_messaging/models/message_model.dart';
import 'package:encrypted_messaging/models/user_model.dart';
import 'package:encrypted_messaging/services/data/firestore_db.dart';

class IFirestoreDb {
  final _db = FirestoreDb();

  Future<String> addUser(UserModel user) async => _db.addUser(user);
  Future<UserModel> getUserFromChat(
          List<dynamic> members, String myUid) async =>
      _db.getUserFromChat(members, myUid);
  Future<UserModel> getUserByUid(String myUid) async => _db.getUserByUid(myUid);
  Stream<List<UserModel>> getUserByName(String query) =>
      _db.getUserByName(query);
  Future<List<MessageModel>> getMessages(String chatUid) async =>
      _db.getMessages(chatUid);

  Future<String> createChat(List<String> ids) async => _db.createChat(ids);
  ChatModel getChatModel(QuerySnapshot<Object?>? msgData, UserModel userModel,
          List<String>? myPrefs, int unreadCount) =>
      _db.getChatModel(msgData, userModel, myPrefs, unreadCount);
}
