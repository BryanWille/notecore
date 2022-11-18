import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notecore/modelos/anotacao.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServicoBD {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final CollectionReference _anotacoesUsuario =
      _firestore.collection("usuarios/${_auth.currentUser!.uid}/anotacoes");
  late final CollectionReference _usuarioPessoa =
      _firestore.collection("usuarios/${_auth.currentUser!.uid}/");

  //Criar Nota
  void criarNota(Anotacao anotacao) async {
    String gerarId = anotacao.idNota!;
    var map = anotacao.paraDicionario();
    await _anotacoesUsuario.doc(gerarId).set(map);
  }


  //Ler todas as notas
  Future<List<Map<String, dynamic>>> retornaNotas() async {
    QuerySnapshot<Object?> snapshot = await _anotacoesUsuario.get();
    final todosIds = snapshot.docs.map((doc) => doc.id).toList();
    List<Map<String, dynamic>> anotacoes = List.empty(growable: true);
    for (var idAnotacao in todosIds) {
      await _anotacoesUsuario
          .doc(idAnotacao)
          .get()
          .then((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        anotacoes.add(data);
      });
    }
    return anotacoes;
  }

  // Ler uma nota
  Future<Map<String, dynamic>> retornaNota(String id) async {
    QuerySnapshot<Object?> snapshot = await _anotacoesUsuario.get();
    Map<String, dynamic> nota = {};
    await _anotacoesUsuario.doc(id).get().then((DocumentSnapshot doc) {
      nota = doc.data() as Map<String, dynamic>;
    });
    return nota;
  }

  // Ler um usuário
  Future<Map<String, dynamic>> retornaUsuario(String id) async {
    QuerySnapshot<Object?> snapshot = await _anotacoesUsuario.get();
    Map<String, dynamic> usuario = {};
    await _usuarioPessoa.doc(id).get().then((DocumentSnapshot doc) {
      usuario = doc.data() as Map<String, dynamic>;
    });
    return usuario;
  }

  //Atualizar Nota
  void atualizarNota(Anotacao nota) {
    var anotacao = nota.paraDicionario();
    _anotacoesUsuario.doc(nota.idNota).set(anotacao);
  }

  //Deletar nota
  void deletarNota(Anotacao nota) {
    var anotacao = nota.paraDicionario();
    _anotacoesUsuario.doc(nota.idNota).delete();
  }

  Stream<QuerySnapshot> get anotacoes {
    return _anotacoesUsuario.snapshots();
  }
}
