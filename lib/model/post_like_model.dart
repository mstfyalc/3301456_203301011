
class PostLikeModel {

  late final String postId;
  late final String userId;
  late final String userName;
  late final String profileImageUrl;


  PostLikeModel({
    required this.postId,
    required this.userId,
    required this.userName,
    required this.profileImageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'userId': userId,
      'userName': userName,
      'profileImageUrl': profileImageUrl
    };
  }

  PostLikeModel.fromMap(Map<String, dynamic> postLikeModel) {
    postId = postLikeModel['postId'];
    userId = postLikeModel['userId'];
    userName = postLikeModel['userName'];
    profileImageUrl = postLikeModel['profileImageUrl'];
  }
}
