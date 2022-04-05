import '../../../model/new_user_model.dart';


abstract class AuthBase {

  NewUserModel? getCurrentUser();
  Future<NewUserModel?> signInWithEmailAndPassword(String email,String password);
  Future<NewUserModel?> signUpWithEmailAndPassword(String email,String password);
  Future<bool> signOut();
  Future<NewUserModel?> signInWithGoogle();


}