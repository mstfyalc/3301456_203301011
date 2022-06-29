import 'package:mychat/model/comment_model.dart';
import 'package:mychat/model/new_user_model.dart';
import 'package:mychat/model/post_like_model.dart';

import '../../../model/chat_profile_model.dart';
import '../../../model/conversations_model.dart';
import '../../../model/message_model.dart';
import '../../../model/post_model.dart';
import '../../../model/story_model.dart';


abstract class DbBase{


  // User work
  Future<bool> saveUser(NewUserModel user);
  Future<NewUserModel?> getUser(String userId);
  Future<NewUserModel?> updateUser(NewUserModel user);
  Future<NewUserModel?> updateUserProfilePhoto(String url,String userId);
  Stream<List<NewUserModel>>? getUserByName(String name);
  Stream<List<NewUserModel>>? getAllUsers();


  //Message work
  Stream<List<ConversationsModel>>? getAllConversations(String userId);
  Stream<List<MessageModel>>? getMessages(String fromId,String toId);
  Future<bool> saveMessage(MessageModel messageToSave,ChatProfileModel chatProfileModel);


  //Post work
  Stream<List<PostModel>>? getPostsByUserId(String userId);
  Future<bool> savePost(PostModel postModel);
  Stream<List<PostModel>> getAllPost();

  //Comment work
  Future<bool> saveComment(CommentModel commentModel);
  Stream<List<CommentModel>>? getAllCommentByPostId(String postId);

  //Conversation work
  Stream<List<ConversationsModel>>? getConversationByName(String conName,String userId);

  //Stories work
  Future<bool> saveStory(StoryModel storyModel);
  Stream<List<StoryModel>>? getAllStories();



}