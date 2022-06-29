import 'package:cloud_firestore/cloud_firestore.dart';

class StoryModel {


  String? storyId;
  late final String fromId;
  late final String fromUserName;
  late final String fromImageUrl;
  late final String storyUrl;
  DateTime? createdAt;


  StoryModel({
    this.storyId,
    required this.fromId,
    required this.fromUserName,
    required this.fromImageUrl,
    required this.storyUrl,
    this.createdAt
  });

  Map<String, dynamic> toMap() {
    return {
      'storyId': storyId,
      'fromId': fromId,
      'fromUserName':fromUserName,
      'fromImageUrl' : fromImageUrl,
      'storyUrl' : storyUrl,
      'createdAt' : createdAt ?? FieldValue.serverTimestamp()
    };
  }


  StoryModel.fromMap(Map<String, dynamic> postModel) {
    storyId = postModel['storyId'];
    fromId = postModel['fromId'];
    fromUserName = postModel['fromUserName'];
    fromImageUrl = postModel['fromImageUrl'];
    storyUrl = postModel['storyUrl'];
    createdAt = (postModel['createdAt'] as Timestamp).toDate();
  }


}