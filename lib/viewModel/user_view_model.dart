import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mychat/model/post_like_model.dart';
import 'package:mychat/model/post_model.dart';
import 'package:mychat/model/story_model.dart';


import '../data/repository/user_auth_repository.dart';
import '../data/repository/user_db_repository.dart';
import '../data/repository/user_storage_repository.dart';
import '../data/service/auth/auth_base.dart';
import '../model/chat_profile_model.dart';
import '../model/comment_model.dart';
import '../model/conversations_model.dart';
import '../model/message_model.dart';
import '../model/new_user_model.dart';

import '../provider/get_it/locator.dart';
import '../ui/constant/constant_color.dart';

enum ViewState { busy, idle }

class UserViewModel with ChangeNotifier implements AuthBase {
  ViewState _viewState = ViewState.idle;

  ViewState get viewState => _viewState;

  set viewState(ViewState value) {
    _viewState = value;
    notifyListeners();
  }

  final UserAuthRepository _userAuthRepository = locator<UserAuthRepository>();
  final UserDbRepository _userDbRepository = locator<UserDbRepository>();
  final UserStorageRepository _userStorageRepository =
      locator<UserStorageRepository>();

  late NewUserModel? _userModel;
  String? emailError;
  String? passwordError;
  Color dominantColor = ConstantColor.appColor;

  NewUserModel? get userModel => _userModel;

  UserViewModel() {
    getCurrentUserFromDb();
  }


  Future<NewUserModel?> getCurrentUserFromDb() async {
    try {
      viewState = ViewState.busy;
      _userModel = await  _userAuthRepository.getCurrentUserFromDb();
      if (_userModel == null) {
        return null;
      } else {
        return _userModel;
      }
    } finally {
      viewState = ViewState.idle;
    }
  }

  @override
  Future<NewUserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    if (_emailAndPasswordValidator(email, password)) {
      try {
        viewState = ViewState.busy;
        _userModel = await _userAuthRepository.signInWithEmailAndPassword(
            email, password);
        return _userModel;
      } finally {
        viewState = ViewState.idle;
      }
    } else {
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      viewState = ViewState.busy;
      bool result = await _userAuthRepository.signOut();
      _userModel = null;
      return result;
    } finally {
      viewState = ViewState.idle;
    }
  }

  @override
  Future<NewUserModel?> signInWithGoogle() async {
    try {
      viewState = ViewState.busy;
      NewUserModel? _currentUser = await _userAuthRepository.signInWithGoogle();
      _userModel = _currentUser;
      return _currentUser;
    } finally {
      viewState = ViewState.idle;
    }
  }

  @override
  Future<NewUserModel?> signUpWithEmailAndPassword(
      String email, String password) async {
    if (_emailAndPasswordValidator(email, password)) {
      try {
        viewState = ViewState.busy;
        NewUserModel? _currentUser = await _userAuthRepository
            .signUpWithEmailAndPassword(email, password);

        _userModel = _currentUser;
        return _currentUser;
      } finally {
        viewState = ViewState.idle;
      }
    } else {
      return null;
    }
  }

  Future<NewUserModel?> updateUser(NewUserModel? userToUpdate) async {
    try {
      viewState = ViewState.busy;
      NewUserModel? updatedUser =
          await _userDbRepository.updateUser(userToUpdate!);
      if (updatedUser != null) {
        _userModel = updatedUser;
      } else {
        return null;
      }
    } finally {
      viewState = ViewState.idle;
    }
    return null;
  }

  bool _emailAndPasswordValidator(String email, String password) {
    bool isValid = true;

    if (!email.contains('@')) {
      emailError = 'Please enter an correct email';
      isValid = false;
    } else {
      emailError = null;
    }
    if (password.length < 6) {
      passwordError = 'Please enter more than 6 char';
      isValid = false;
    } else {
      passwordError = null;
    }
    return isValid;
  }

  Future<NewUserModel?> uploadProfilePhoto(
      String userId, String path, File photo) async {
    try {
      viewState = ViewState.busy;
      String url =
          await _userStorageRepository.uploadProfilePhoto(userId, path, photo);
      NewUserModel? _user =
          await _userDbRepository.updateUserProfilePhoto(url, userId);
      if (_user != null) {
        _userModel = _user;
      } else {
        return null;
      }
    } finally {
      viewState = ViewState.idle;
    }
    return null;
  }

  Stream<List<NewUserModel>>? getAllUsers() {
    return _userDbRepository.getAllUsers();
  }

  Stream<List<ConversationsModel>>? getAllConversations(String userId) {
    return _userDbRepository.getAllConversations(userId);
  }

  Stream<List<NewUserModel>>? getUserByName(String name) {
    return _userDbRepository.getUserByName(name);
  }

  Stream<List<MessageModel>>? getMessages(String fromId, String toId) {
    return _userDbRepository.getMessages(fromId, toId);
  }

  Future<bool> saveMessage(
      MessageModel messageToSave, ChatProfileModel chatProfileModel) {
    return _userDbRepository.saveMessage(messageToSave, chatProfileModel);
  }

  Future<NewUserModel?> getUserById(String userId) async {
    return await _userDbRepository.getUser(userId);
  }



  Future<String> getPostUrl(String userId,String path,File photo) async {
    return await _userStorageRepository.uploadPost(userId, path, photo);
  }

  Future<bool> savePost(PostModel postModel) async{
    try{
      viewState = ViewState.busy;
      bool result = await _userDbRepository.savePost(postModel);
      return result;
    }finally{
      viewState = ViewState.idle;
    }

  }

  @override
  NewUserModel? getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }


  Future<bool> saveComment(CommentModel commentModel) async{
    return  await _userDbRepository.saveComment(commentModel);
  }



  Stream<List<CommentModel>>? getAllCommentsByPostId(String postId){
    return _userDbRepository.getAllCommentByPostId(postId);
  }


  Future<bool> saveStory(StoryModel storyModel){
    return _userDbRepository.saveStory(storyModel);
  }

  Stream<List<StoryModel>>? getAllStories(){
    return _userDbRepository.getAllStories();
  }









}
