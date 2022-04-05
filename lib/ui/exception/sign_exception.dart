
class SignException {

  static String showException(String exceptionCode){
    switch (exceptionCode){
      case 'email-already-in-use':
        return 'This email already in use.Please try another one';
      case 'wrong-password':
        return 'Wrong password';
      case 'user-not-found':
        return 'User not found';
      default:
        return 'Default';
    }

  }



}