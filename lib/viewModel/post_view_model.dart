import 'package:flutter/material.dart';
import 'package:mychat/model/comment_model.dart';
import 'package:mychat/model/new_user_model.dart';
import 'package:mychat/ui/constant/constant_style.dart';

import '../data/repository/user_auth_repository.dart';
import '../data/repository/user_db_repository.dart';
import '../data/repository/user_storage_repository.dart';
import '../model/post_model.dart';
import '../provider/get_it/locator.dart';


enum PostViewState{idle,busy,error,loaded}


class PostViewModel extends ChangeNotifier{

  final UserAuthRepository _userAuthRepository = locator<UserAuthRepository>();
  final UserDbRepository _userDbRepository = locator<UserDbRepository>();
  final UserStorageRepository _userStorageRepository =
  locator<UserStorageRepository>();

  // Current user
  late NewUserModel? _currentUser;
  NewUserModel? get currentUser => _currentUser;
  set currentUser(NewUserModel? value) {
    _currentUser = value;
    notifyListeners();
  }

  PostViewModel(){
    getCurrentUserFromDb();
  }



  Stream<List<PostModel>>? getPostsByUserId(String userId) {
    return _userDbRepository.getPostsByUserId(userId);
  }

  Stream<List<PostModel>> getAllPost(){
   return _userDbRepository.getAllPost();
  }

  Future<bool> saveComment(CommentModel commentModel) async{
    return  await _userDbRepository.saveComment(commentModel);
  }


  Future<NewUserModel?> getCurrentUserFromDb() async {
      currentUser = await _userAuthRepository.getCurrentUserFromDb();
      if (currentUser == null) {
        return null;
      } else {
        return currentUser;
      }
  }











}