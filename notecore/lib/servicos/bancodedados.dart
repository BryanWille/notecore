import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notecore/modelos/anotacao.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServicoBD {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final CollectionReference _anotacoesUsuario =
      _firestore.collection("usuarios/${_auth.currentUser!.uid}/anotacoes");

  void criarNota(Anotacao anotacao) async {
    var map = anotacao.paraDicionario();
    await _anotacoesUsuario.doc().set(map);
  }


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

  Stream<QuerySnapshot> get anotacoes {
    return _anotacoesUsuario.snapshots();
  }
}
