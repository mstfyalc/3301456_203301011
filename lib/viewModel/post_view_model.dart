import 'package:flutter/material.dart';

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


  Stream<List<PostModel>>? getPostsByUserId(String userId) {
    return _userDbRepository.getPostsByUserId(userId);
  }




}