

import 'dart:io';



import 'package:flutter/material.dart';

import '../../provider/get_it/locator.dart';
import '../service/storage/firebase_storage_service.dart';
import '../service/storage/storage_base.dart';

class UserStorageRepository implements StorageBase{

  final FireBaseStorageService _fireBaseStorageService = locator<FireBaseStorageService>();

  @override
  Future<String> uploadProfilePhoto(String userId,String path,File photo) async{
    debugPrint('User storage repo start');
    return await _fireBaseStorageService.uploadProfilePhoto(userId, path, photo);
  }

  @override
  Future<String> uploadPost(String userId, String path, File photo) async {
    return await _fireBaseStorageService.uploadPost(userId, path, photo);
  }

}