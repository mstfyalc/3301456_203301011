

import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'storage_base.dart';

class FireBaseStorageService implements StorageBase {


  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;


  @override
  Future<String> uploadProfilePhoto(String userId, String path, File photo) async {
    debugPrint('Firebase storage service start');
    TaskSnapshot taskSnapshot =  await _firebaseStorage.ref('users/$userId/$path/${Random().nextInt(1550)}').putFile(photo);
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Future<String> uploadPost(String userId, String path, File photo) async {
    debugPrint('uploadPost');
    TaskSnapshot taskSnapshot =  await _firebaseStorage.ref('post/$userId/$path/${Random().nextInt(1550)}').putFile(photo);
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

}