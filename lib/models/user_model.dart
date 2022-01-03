import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  final String uid;
  @HiveField(2)
  final String fName;
  @HiveField(3)
  final String lName;
  @HiveField(4)
  final bool isActive;
  @HiveField(5)
  final String photoUrl;
  @HiveField(6)
  final String publicKey;

  UserModel(
      {this.id,
      required this.uid,
      required this.fName,
      required this.lName,
      required this.isActive,
      required this.photoUrl,
      required this.publicKey});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fName': fName,
      'lName': lName,
      'isActive': isActive,
      'photoUrl': photoUrl,
      'publicKey': publicKey,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      fName: map['fName'],
      lName: map['lName'],
      isActive: map['isActive'],
      photoUrl: map['photoUrl'],
      publicKey: map['publicKey'],
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    return UserModel(
      id: snap.id,
      uid: snap['uid'],
      fName: snap['fName'],
      lName: snap['lName'],
      isActive: snap['isActive'],
      photoUrl: snap['photoUrl'],
      publicKey: snap['publicKey'],
    );
  }
}
