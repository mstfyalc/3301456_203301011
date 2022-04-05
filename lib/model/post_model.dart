import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {

  String? postId;
  late final String fromId;
  late final String postUrl;
  late final String fromName;
  late final String fromImageUrl;
  String? description;
  int? likes;
  DateTime? createdAt;


  PostModel(
      {
        required this.fromId,
        required this.postUrl,
        required this.fromName,
        required this.fromImageUrl,
        this.description,
        this.likes,
        this.createdAt,
        });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'fromId': fromId,
      'postUrl':postUrl,
      'fromName' : fromName,
      'fromImageUrl' : fromImageUrl,
      'description': description ?? '',
      'likes' : likes ?? 0,
      'createdAt' : createdAt ?? FieldValue.serverTimestamp()
    };
  }

  PostModel.fromMap(Map<String, dynamic> postModel) {
    postId = postModel['postId'];
    fromId = postModel['fromId'];
    postUrl = postModel['postUrl'];
    fromName = postModel['fromName'];
    fromImageUrl = postModel['fromImageUrl'];
    description = postModel['description'];
    likes = postModel['likes'];
    createdAt = (postModel['createdAt'] as Timestamp).toDate();

  }

}