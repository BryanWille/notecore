import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notecore/modelos/anotacao.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class ServicoBD {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final CollectionReference _anotacoesUsuario =
      _firestore.collection("usuarios/${_auth.currentUser!.uid}/anotacoes");

  //Criar
  void criarNota(Anotacao anotacao) async {
    String gerarId = DateTime.now().microsecondsSinceEpoch.toString();
    anotacao.idNota = gerarId;
    var map = anotacao.paraDicionario();
    await _anotacoesUsuario.doc(gerarId).set(map);
  }

  //Ler
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

  //Atualizar Nota
  void atualizarNota(Anotacao nota) {
    var anotacao = nota.paraDicionario();
    _anotacoesUsuario.doc(nota.idNota).set(anotacao);
  }

  Stream<QuerySnapshot> get anotacoes {
    return _anotacoesUsuario.snapshots();
  }
}
