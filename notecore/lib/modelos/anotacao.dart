class Anotacao {
  int? id;
  String? userId;
  String? titulo;
  String? descricao;
  DateTime? horaCriacao;

  Anotacao(this.id, this.userId, this.titulo, this.descricao, this.horaCriacao);

  Map<String, dynamic> paraDicionario() {
    var map = <String, dynamic>{
      'id': id,
      'userId': userId,
      'titulo': titulo,
      'descricao': descricao,
      'horaCriacao': horaCriacao,
    };
    return map;
  }

  Anotacao.deDicionario(Map<String, dynamic> map) {
    id = map['id'];
    userId = map['userId'];
    titulo = map['titulo'];
    descricao = map['descricao'];
    horaCriacao = map['horaCriacao'];
  }

  Anotacao.deJSON(Map<String, dynamic> map) {
    id = map['id'];
    userId = map['userId'];
    titulo = map['titulo'];
    descricao = map['descricao'];
    horaCriacao = map['horaCriacao'];
  }

  @override
  String toString() {
    return "Produto => (id: $id, userId: $userId, titulo: $titulo, descricao: $descricao, data: $horaCriacao)";
  }
}
