import 'package:mychat/model/post_model.dart';

import '../../../model/chat_profile_model.dart';
import '../../../model/conversations_model.dart';
import '../../../model/message_model.dart';
import '../../../model/new_user_model.dart';

import 'db_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreDbService implements DbBase {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future<bool> saveUser(NewUserModel user) async {
    await _fireStore.collection('users').doc(user.userId).set(user.toMap());

    return true;
  }

  @override
  Future<NewUserModel?> getUser(String userId) async {
    DocumentSnapshot? _user =
        await _fireStore.collection('users').doc(userId).get();
    if (_user.exists) {
      Map<String, dynamic> _userMap = _user.data() as Map<String, dynamic>;
      NewUserModel user = NewUserModel.fromMap(_userMap);
      return user;
    } else {
      return null;
    }
  }

  @override
  Future<NewUserModel?> updateUser(NewUserModel user) async {
    await _fireStore.collection('users').doc(user.userId).set(user.toMap());
    return user;
  }

  @override
  Future<NewUserModel?> updateUserProfilePhoto(
      String url, String userId) async {
    await _fireStore
        .collection('users')
        .doc(userId)
        .update({'profileImageUrl': url});
    NewUserModel? _user = await getUser(userId);
    return _user;
  }

  @override
  Stream<List<NewUserModel>>? getAllUsers() {
    return _fireStore.collection('users').snapshots().map((snapShots) =>
        snapShots.docs.map((doc) => NewUserModel.fromMap(doc.data())).toList());
  }

  @override
  Stream<List<NewUserModel>>? getUserByName(String name) {
    return _fireStore
        .collection('users')
        .where('userName', isEqualTo: name)
        .snapshots()
        .map((snapShots) => snapShots.docs
            .map((doc) => NewUserModel.fromMap(doc.data()))
            .toList());
  }

  @override
  Stream<List<MessageModel>>? getMessages(String fromId, String toId) {
    return _fireStore
        .collection('conversations')
        .doc(fromId + '-' + toId)
        .collection('messages')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapShots) => snapShots.docs
            .map((doc) => MessageModel.fromMap(doc.data()))
            .toList());
  }

  @override
  Future<bool> saveMessage(
      MessageModel messageToSave, ChatProfileModel chatProfileModel) async {
    String messageId = _fireStore.collection('conversations').doc().id;
    String myMessageDocumentId = messageToSave.from + '-' + messageToSave.to;
    String receiverMessageDocumentId =
        messageToSave.to + '-' + messageToSave.from;

    Map<String, dynamic> messageToMap = messageToSave.toMap();

    // Save message for me
    await _fireStore
        .collection('conversations')
        .doc(myMessageDocumentId)
        .collection('messages')
        .doc(messageId)
        .set(messageToMap);

    ConversationsModel myConversation = ConversationsModel(
        fromWho: messageToSave.from,
        toWho: messageToSave.to,
        lastMessage: messageToSave.message,
        fromName: chatProfileModel.fromName,
        fromProfile: chatProfileModel.fromProfile,
        toName: chatProfileModel.toName,
        toProfile: chatProfileModel.toProfile);

    // Save Conversation for me
    await _fireStore
        .collection('conversations')
        .doc(myMessageDocumentId)
        .set(myConversation.toMap());

    messageToMap.update('isFromMe', (value) => false);

    // Save message for receiver
    await _fireStore
        .collection('conversations')
        .doc(receiverMessageDocumentId)
        .collection('messages')
        .doc(messageId)
        .set(messageToMap);

    ConversationsModel receiverConversation = ConversationsModel(
        fromWho: messageToSave.to,
        toWho: messageToSave.from,
        lastMessage: messageToSave.message,
        fromName: chatProfileModel.toName,
        fromProfile: chatProfileModel.toProfile,
        toName: chatProfileModel.fromName,
        toProfile: chatProfileModel.fromProfile);

    // Save Conversation for me
    await _fireStore
        .collection('conversations')
        .doc(receiverMessageDocumentId)
        .set(receiverConversation.toMap());

    return true;
  }

  @override
  Stream<List<ConversationsModel>>? getAllConversations(String userId) {
    return _fireStore
        .collection('conversations')
        .where('fromWho', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshots) => snapshots.docs
            .map((doc) => ConversationsModel.fromMap(doc.data()))
            .toList());
  }

  @override
  Future<bool> savePost(PostModel postModel) async {
    String postId = _fireStore.collection('posts').doc().id;

    postModel.postId = postId;

    // Save post
    await _fireStore
        .collection('post')
        .doc(postModel.fromId)
        .collection('posts')
        .doc(postId)
        .set(postModel.toMap());

    return true;
  }

  @override
  Stream<List<PostModel>>? getPostsByUserId(String userId) {
    return _fireStore
        .collection('post')
        .doc(userId)
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshots) => snapshots.docs
            .map((doc) => PostModel.fromMap(doc.data()))
            .toList());
  }

  @override
  Future<void> increasePostLike(String postId, String userId) async {
    int globalLike = 0;
    DocumentSnapshot? _post = await _fireStore
        .collection('post')
        .doc(userId)
        .collection('posts')
        .doc(postId)
        .get();

    if (_post.exists) {
      Map<String, dynamic> _postMap = _post.data() as Map<String, dynamic>;
      PostModel post = PostModel.fromMap(_postMap);
      int? like = post.likes;

      globalLike = like! + 1;

      await _fireStore
          .collection('post')
          .doc(userId)
          .collection('posts')
          .doc(postId)
          .update({'likes': globalLike});
    }
  }

  @override
  Future<void> decreasePostLike(String postId, String userId) async {
    int globalLike = 0;
    DocumentSnapshot? _post = await _fireStore
        .collection('post')
        .doc(userId)
        .collection('posts')
        .doc(postId)
        .get();

    if (_post.exists) {
      Map<String, dynamic> _postMap = _post.data() as Map<String, dynamic>;
      PostModel post = PostModel.fromMap(_postMap);
      int? like = post.likes;
      if (like! > 0) {
        globalLike = like - 1;

        await _fireStore
            .collection('post')
            .doc(userId)
            .collection('posts')
            .doc(postId)
            .update({'likes': globalLike});
      }
    }
  }
}
