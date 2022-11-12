import 'package:firebase_auth/firebase_auth.dart';
import 'package:notecore/modelos/usuario.dart';

class AuthServico {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // criar o usuário baseado no FireBaseUser
  Usuario? _usuarioDoFirebaseUser(User? usuario) {
    return usuario != null ? Usuario(uid: usuario.uid) : null;
  }

  // Stream de mudança
  Stream<Usuario?> get usuario {
    return _auth.authStateChanges().map(_usuarioDoFirebaseUser);
  }

  // login anonimo
  Future logarAnonimo() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _usuarioDoFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // login com email e senha

  // registro com email e senha
  Future registroComEmaileSenha(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User usuario = result.user!;
      return _usuarioDoFirebaseUser(usuario);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // deslogar
  Future deslogar() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}