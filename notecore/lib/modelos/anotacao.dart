import 'package:cloud_firestore/cloud_firestore.dart';

class Anotacao {
  String? idNota;
  String? titulo;
  String? descricao;
  Timestamp? horaCriacao;

  Anotacao(this.titulo, this.descricao, this.horaCriacao, {this.idNota});

  Map<String, dynamic> paraDicionario() {
    var map = <String, dynamic>{
      'idNota': idNota,
      'titulo': titulo,
      'descricao': descricao,
      'horaCriacao': horaCriacao,
    };
    return map;
  }

  Anotacao.deDicionario(Map<String, dynamic> map) {
    idNota = map['idNota'];
    titulo = map['titulo'];
    descricao = map['descricao'];
    horaCriacao = map['horaCriacao'];
  }

  factory Anotacao.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Anotacao(
      idNota: data?['idNota'],
      data?['titulo'],
      data?['descricao'],
      data?['horaCriacao'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (idNota != null) "idNota": idNota,
      if (titulo != null) "titulo": titulo,
      if (descricao != null) "descricao": descricao,
      if (horaCriacao != null) "horaCriacao": horaCriacao,
    };
  }

  Anotacao.fromJson(Map<String, dynamic> map) {
    idNota = map['idNota'];
    titulo = map['titulo'];
    descricao = map['descricao'];
    horaCriacao = map['horaCriacao'];
  }

  @override
  String toString() {
    return "Anoptações => (titulo: $titulo, descricao: $descricao, data: $horaCriacao, idNota: $idNota)";
  }
}
