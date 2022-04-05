import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../model/new_user_model.dart';
import 'auth_base.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  NewUserModel? getCurrentUser()  {
    User? _firebaseUser =  _firebaseAuth.currentUser;
    NewUserModel? _currentUser = _userToUserModel(_firebaseUser);
    return _currentUser;
  }

  @override
  Future<NewUserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential _userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    NewUserModel? _currentUser = _userToUserModel(_userCredential.user);
    return _currentUser;
  }

  @override
  Future<bool> signOut() async {
    // Google signOut
    final _googleSignIn = GoogleSignIn();
    await _googleSignIn.signOut();
    //Firebase signOut
    await _firebaseAuth.signOut();
    return true;
  }

  NewUserModel? _userToUserModel(User? firebaseUser) {
    if (firebaseUser == null) {
      return null;
    } else {
      return NewUserModel(userId: firebaseUser.uid, email: firebaseUser.email!);
    }
  }

  @override
  Future<NewUserModel?> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? _googleAccount = await _googleSignIn.signIn();

    if (_googleAccount != null) {
      GoogleSignInAuthentication _signInAuth =
          await _googleAccount.authentication;
      if (_signInAuth.accessToken != null && _signInAuth.idToken != null) {
        UserCredential _userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
                idToken: _signInAuth.idToken,
                accessToken: _signInAuth.accessToken));
        NewUserModel? _currentUser = _userToUserModel(_userCredential.user);
        return _currentUser;
      }
      return null;
    }
    return null;
  }

  @override
  Future<NewUserModel?> signUpWithEmailAndPassword(
      String email, String password) async {
    UserCredential _userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    NewUserModel? _currentUser = _userToUserModel(_userCredential.user);
    return _currentUser;
  }
}
