import 'package:firebase_auth/firebase_auth.dart';
import 'package:notecore/modelos/usuario.dart';
import 'package:notecore/servicos/bancodedados.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthServico {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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
      await _db
          .doc("caminho")
          .collection("teste")
          .add({"teste": DateTime.now()});
      return _usuarioDoFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // login com email e senha
  Future loginComEmailESenha(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User usuario = result.user!;
      return _usuarioDoFirebaseUser(usuario);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

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
