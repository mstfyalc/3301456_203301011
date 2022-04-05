
import 'dart:io';


abstract class StorageBase{

  Future<String> uploadProfilePhoto(String userId,String path,File photo);
  Future<String> uploadPost(String userId,String path,File photo);

}