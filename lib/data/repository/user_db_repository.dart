import 'package:mychat/model/chat_profile_model.dart';
import 'package:mychat/model/conversations_model.dart';
import 'package:mychat/model/message_model.dart';
import 'package:mychat/model/post_model.dart';

import '../../model/new_user_model.dart';
import '../../provider/get_it/locator.dart';
import '../service/db/db_base.dart';
import '../service/db/firestore_db_service.dart';

enum AppMode { debug, release }

class UserDbRepository implements DbBase {
  final AppMode _appMode = AppMode.release;
  final FireStoreDbService _dbService = locator<FireStoreDbService>();

  @override
  Future<NewUserModel?> getUser(String userId) async {
    if (_appMode == AppMode.release) {
      NewUserModel? _user = await _dbService.getUser(userId);
      if (_user != null) {
        return _user;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<bool> saveUser(NewUserModel user) async {
    if (_appMode == AppMode.release) {
      bool result = await _dbService.saveUser(user);
      return result;
    } else {
      return false;
    }
  }

  @override
  Future<NewUserModel?> updateUser(NewUserModel user) async {
    if (_appMode == AppMode.release) {
      NewUserModel? _user = await _dbService.updateUser(user);
      if (_user != null) {
        return _user;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<NewUserModel?> updateUserProfilePhoto(
      String url, String userId) async {
    return await _dbService.updateUserProfilePhoto(url, userId);
  }

  @override
  Stream<List<NewUserModel>>? getAllUsers() {
    return _dbService.getAllUsers();
  }

  @override
  Stream<List<NewUserModel>>? getUserByName(String name) {
    return _dbService.getUserByName(name);
  }

  @override
  Stream<List<MessageModel>>? getMessages(String fromId, String toId) {
    return _dbService.getMessages(fromId, toId);
  }

  @override
  Future<bool> saveMessage(
      MessageModel messageToSave, ChatProfileModel chatProfileModel) {
    return _dbService.saveMessage(messageToSave, chatProfileModel);
  }

  @override
  Stream<List<ConversationsModel>>? getAllConversations(String userId) {
    return _dbService.getAllConversations(userId);
  }

  @override
  Future<bool> savePost(PostModel postModel) {
    return _dbService.savePost(postModel);
  }

  @override
  Stream<List<PostModel>>? getPostsByUserId(String userId) {
    return _dbService.getPostsByUserId(userId);
  }

  @override
  Future<void> increasePostLike(String postId,String userId) {
    return _dbService.increasePostLike(postId,userId);
  }

  @override
  Future<void> decreasePostLike(String postId,String userId) {
    return _dbService.decreasePostLike(postId,userId);
  }





}
