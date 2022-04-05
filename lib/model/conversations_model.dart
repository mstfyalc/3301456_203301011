import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationsModel {
  late final String fromWho;
  late final String toWho;
  late final String toName;
  late final String fromName;
  late final String toProfile;
  late final String fromProfile;
  late final String lastMessage;
  late final Timestamp? createdAt;
  late final Timestamp? dateOfSight;

  ConversationsModel(
      {required this.fromWho,
      required this.toWho,
      required this.toName,
      required this.toProfile,
      required this.fromName,
      required this.fromProfile,
      required this.lastMessage,
      this.createdAt,
      this.dateOfSight});

  Map<String, dynamic> toMap() {
    return {
      'fromWho': fromWho,
      'toWho': toWho,
      'toName': toName,
      'fromName': fromName,
      'toProfile': toProfile,
      'fromProfile': fromProfile,
      'lastMessage': lastMessage,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'dateOfSight': dateOfSight ?? FieldValue.serverTimestamp(),
    };
  }

  ConversationsModel.fromMap(Map<String, dynamic> userModelMap) {
    fromWho = userModelMap['fromWho'];
    toWho = userModelMap['toWho'];
    toName = userModelMap['toName'];
    fromName = userModelMap['fromName'];
    toProfile = userModelMap['toProfile'];
    fromProfile = userModelMap['fromProfile'];
    lastMessage = userModelMap['lastMessage'];
    createdAt = userModelMap['createdAt'];
    dateOfSight = userModelMap['dateOfSight'];
  }
}
