import 'package:flutter/material.dart';
import 'package:mychat/data/service/db/firestore_db_service.dart';

import '../../model/new_user_model.dart';
import '../../provider/get_it/locator.dart';
import '../service/auth/auth_base.dart';
import '../service/auth/fake_auth_service.dart';
import '../service/auth/firebase_auth_service.dart';

enum AppMode { debug, release }

class UserAuthRepository implements AuthBase {
  final FirebaseAuthService _firebaseAuthService =
      locator<FirebaseAuthService>();
  final FakeAuthService _fakeAuthService = locator<FakeAuthService>();
  final FireStoreDbService _dbService = locator<FireStoreDbService>();

  final AppMode _appMode = AppMode.release;


  Future<NewUserModel?> getCurrentUserFromDb() async {
    if (_appMode == AppMode.release) {
      NewUserModel? _authUser =  _firebaseAuthService.getCurrentUser();
      if (_authUser != null) {
        NewUserModel? _user = await _dbService.getUser(_authUser.userId);
        return _user;
      }
      return null;
    } else {
      return _fakeAuthService.getCurrentUser();
    }
  }

  @override
  Future<NewUserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    if (_appMode == AppMode.release) {
      NewUserModel? _authUser = await _firebaseAuthService
          .signInWithEmailAndPassword(email, password);
      NewUserModel? _user = await _dbService.getUser(_authUser!.userId);
      return _user;
    } else {
      return await _fakeAuthService.signInWithEmailAndPassword(email, password);
    }
  }

  @override
  Future<bool> signOut() async {
    if (_appMode == AppMode.release) {
      bool result = await _firebaseAuthService.signOut();
      return result;
    } else {
      bool result = await _fakeAuthService.signOut();
      return result;
    }
  }

  @override
  Future<NewUserModel?> signInWithGoogle() async {
    if (_appMode == AppMode.release) {
      NewUserModel? _currentUser = await _firebaseAuthService.signInWithGoogle();
      if (_currentUser != null) {
        NewUserModel? _user = await _dbService.getUser(_currentUser.userId);
        if (_user != null) {
          debugPrint('User already exists');
          return _user;
        } else {
          bool result = await _dbService.saveUser(_currentUser);
          if (result == true) {
            debugPrint('User saved');
            NewUserModel? _user = await _dbService.getUser(_currentUser.userId);
            return _user;
          } else {
            debugPrint('User not saved');
            return null;
          }
        }
      }
    } else {
      NewUserModel? _currentUser = await _fakeAuthService.signInWithGoogle();
      return _currentUser;
    }
    return null;
  }

  @override
  Future<NewUserModel?> signUpWithEmailAndPassword(
      String email, String password) async {
    if (_appMode == AppMode.release) {
      NewUserModel? _currentUser = await _firebaseAuthService
          .signUpWithEmailAndPassword(email, password);
      bool result = await _dbService.saveUser(_currentUser!);
      if (result == true) {
        NewUserModel? _user = await _dbService.getUser(_currentUser.userId);
        return _user;
      } else {
        return null;
      }
    } else {
      NewUserModel? _currentUser =
          await _fakeAuthService.signUpWithEmailAndPassword(email, password);
      return _currentUser;
    }
  }

  @override
  NewUserModel? getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }
}
