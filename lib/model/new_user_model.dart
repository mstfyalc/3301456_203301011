import 'package:cloud_firestore/cloud_firestore.dart';

class NewUserModel {
  late final String userId;
  late String email;
  String? userName;
  String? name;
  String? profileImageUrl;
  String? description;
  DateTime? createdAt;


  NewUserModel({
    required this.userId,
    required this.email,
    this.userName,
    this.name,
    this.profileImageUrl,
    this.description,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'userName': userName ?? email.substring(0, email.indexOf('@')),
      'name': name ?? email.substring(0, email.indexOf('@')),
      'profileImageUrl': profileImageUrl ??
          'https://alz.org.tr/wp-content/uploads/2021/06/nopic.png',
      'description': description ?? '',
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),

    };
  }

  NewUserModel.fromMap(Map<String, dynamic> newUserModelMap) {
    userId = newUserModelMap['userId'];
    email = newUserModelMap['email'];
    userName = newUserModelMap['userName'];
    name = newUserModelMap['name'];
    profileImageUrl = newUserModelMap['profileImageUrl'];
    description = newUserModelMap['description'];
    createdAt = (newUserModelMap['createdAt'] as Timestamp).toDate();

  }
}
