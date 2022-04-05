import 'package:mychat/model/new_user_model.dart';

import '../../../model/chat_profile_model.dart';
import '../../../model/conversations_model.dart';
import '../../../model/message_model.dart';
import '../../../model/post_model.dart';


abstract class DbBase{
  Future<bool> saveUser(NewUserModel user);
  Future<NewUserModel?> getUser(String userId);
  Future<NewUserModel?> updateUser(NewUserModel user);
  Future<NewUserModel?> updateUserProfilePhoto(String url,String userId);
  Stream<List<NewUserModel>>? getUserByName(String name);
  Stream<List<NewUserModel>>? getAllUsers();
  Stream<List<PostModel>>? getPostsByUserId(String userId);
  Stream<List<ConversationsModel>>? getAllConversations(String userId);
  Stream<List<MessageModel>>? getMessages(String fromId,String toId);
  Future<bool> saveMessage(MessageModel messageToSave,ChatProfileModel chatProfileModel);
  Future<bool> savePost(PostModel postModel);
  Future<void> increasePostLike(String postId,String userId);
  Future<void> decreasePostLike(String postId,String userId);
}