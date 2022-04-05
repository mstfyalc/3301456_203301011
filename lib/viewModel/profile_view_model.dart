import 'dart:io';

import 'package:flutter/material.dart';

import '../data/repository/user_auth_repository.dart';
import '../data/repository/user_db_repository.dart';
import '../data/repository/user_storage_repository.dart';
import '../model/new_user_model.dart';
import '../model/post_model.dart';
import '../provider/get_it/locator.dart';

enum ProfileViewState { idle, busy, loaded, error }

class ProfileViewModel extends ChangeNotifier {
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

  // Current state
  ProfileViewState _currentState = ProfileViewState.idle;

  ProfileViewState get currentState => _currentState;

  set currentState(ProfileViewState value) {
    _currentState = value;
    notifyListeners();
  }

  bool isLiked = false;

  ProfileViewModel() {
    getCurrentUserFromDb();
  }

  Future<NewUserModel?> getCurrentUserFromDb() async {
    try {
      currentState = ProfileViewState.busy;
      currentUser = await _userAuthRepository.getCurrentUserFromDb();
      if (currentUser == null) {
        return null;
      } else {
        return currentUser;
      }
    } finally {
      currentState = ProfileViewState.idle;
    }
  }

  Future<NewUserModel?> uploadProfilePhoto(String url, String userId) async {
    try {
      currentState = ProfileViewState.busy;
      NewUserModel? _user =
          await _userDbRepository.updateUserProfilePhoto(url, userId);
      if (_user != null) {
        currentUser = _user;
      } else {
        return null;
      }
    } finally {
      currentState = ProfileViewState.idle;
    }
    return null;
  }

  Future<String?> getProfilePhoto(
      String userId, String path, File photo) async {
    try {
      currentState = ProfileViewState.busy;
      _currentUser!.profileImageUrl =
          await _userStorageRepository.uploadProfilePhoto(userId, path, photo);
      return _currentUser!.profileImageUrl;
    } finally {
      currentState = ProfileViewState.idle;
    }
  }

  Future<NewUserModel?> updateUser(NewUserModel? userToUpdate) async {
    try {
      currentState = ProfileViewState.busy;
      NewUserModel? updatedUser =
          await _userDbRepository.updateUser(userToUpdate!);
      if (updatedUser != null) {
        currentUser = updatedUser;
      } else {
        return null;
      }
    } finally {
      currentState = ProfileViewState.idle;
    }
    return null;
  }

  Future<String> getPostUrl(String userId, String path, File photo) async {
    return await _userStorageRepository.uploadPost(userId, path, photo);
  }

  Future<bool> savePost(PostModel postModel) async {
    try {
      currentState = ProfileViewState.busy;
      bool result = await _userDbRepository.savePost(postModel);
      return result;
    } finally {
      currentState = ProfileViewState.idle;
    }
  }

  Stream<List<PostModel>>? getPostsByUserId(String userId) {
    return _userDbRepository.getPostsByUserId(userId);
  }

  Future<void> decreasePostLike(String postId,String fromId){
    return _userDbRepository.decreasePostLike(postId, fromId);
  }

  Future<void> increasePostLike(String postId,String fromId){
    return _userDbRepository.increasePostLike(postId, fromId);
  }




}
