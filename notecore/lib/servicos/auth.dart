import 'package:firebase_auth/firebase_auth.dart';

class AuthServico {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // login anonimo
  Future logarAnonimo() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // login com email e senha

  // registro com email e senha

  // sign out

}
