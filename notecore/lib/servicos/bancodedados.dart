import 'package:cloud_firestore/cloud_firestore.dart';

class ServicoBancoDados {
  final String uid;
  ServicoBancoDados({required this.uid});

  final CollectionReference anotacoes =
      FirebaseFirestore.instance.collection("anotacoes");

  Future atualizarDadosUsuarios(
      String titulo, String anotacao, DateTime data) async {
    return await anotacoes.doc(uid).set({
      'titulo': titulo,
      'anotacao': anotacao,
      'dataAnotacao': data,
    });
  }
}
