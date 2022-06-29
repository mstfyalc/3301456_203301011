import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {

  String? id;
  late final String postId;
  late final String fromId;
  late final String fromUserName;
  late final String fromImgUrl;
  late final String comment;
  DateTime? createdAt;


  CommentModel({
    required this.postId,
    required this.fromId,
    required this.fromUserName,
    required this.fromImgUrl,
    required this.comment,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'postId': postId,
      'fromId': fromId,
      'fromUserName': fromUserName,
      'fromImgUrl' : fromImgUrl,
      'comment' : comment,
      'createdAt' : createdAt ?? FieldValue.serverTimestamp()
    };
  }


  CommentModel.fromMap(Map<String, dynamic> commentModel) {
    id = commentModel['id'];
    postId = commentModel['postId'];
    fromId = commentModel['fromId'];
    fromUserName = commentModel['fromUserName'];
    fromImgUrl = commentModel['fromImgUrl'];
    comment = commentModel['comment'];
    createdAt = (commentModel['createdAt'] as Timestamp).toDate();

  }





}