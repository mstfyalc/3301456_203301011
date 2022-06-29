
import 'package:flutter/material.dart';
import 'package:mychat/model/new_user_model.dart';

import '../data/repository/user_db_repository.dart';
import '../model/post_model.dart';
import '../provider/get_it/locator.dart';


enum UserDetailViewState{idle, busy, loaded, error}

class UserDetailViewModel extends ChangeNotifier{

  final UserDbRepository _userDbRepository = locator<UserDbRepository>();


  // Current user
  late NewUserModel? _currentUser;
  NewUserModel? get currentUser => _currentUser;
  set currentUser(NewUserModel? value) {
    _currentUser = value;
    notifyListeners();
  }

  // Current ViewState
  UserDetailViewState _currentViewState =  UserDetailViewState.idle;
  UserDetailViewState get currentViewState => _currentViewState;
  set currentViewState(UserDetailViewState value) {
    _currentViewState = value;
    notifyListeners();
  }


  UserDetailViewModel(String userId){
    getCurrentUserById(userId);
  }


  Future<NewUserModel?> getCurrentUserById(String userId) async {
    try {
      currentViewState = UserDetailViewState.busy;
      currentUser = await _userDbRepository.getUser(userId);
      if (currentUser == null) {
        return null;
      } else {
        return currentUser;
      }
    } finally {
      currentViewState = UserDetailViewState.idle;
    }
  }


  Stream<List<PostModel>>? getPostsByUserId(String userId) {
    return _userDbRepository.getPostsByUserId(userId);
  }















}