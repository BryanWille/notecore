import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notecore/modelos/anotacao.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    //uploadData();
    super.onReady();
  }

  Future<void> uploadData() async {
    final _firestore = FirebaseFirestore.instance;
    final user = <String, dynamic>{
      "first": "Brtya",
      "middle": "Mathsadasdasdasison",
      "last": "Turingsadasdasd",
      "born": 19230
    };
    final CollectionReference _Collection = _firestore.collection('teste');
    DocumentReference documentReferencer = _Collection.doc();

    // Add a new document with a generated ID
    try {
      await documentReferencer.set(user);
    } catch (e) {
      print(e);
    }

    /*
    try {
      Anotacao anotacao = Anotacao(213, "2j2i0123sads2", "Esse é o titulo",
          "12312312oiwoda descriasado0", DateTime.now());
      var batch = fireStore.batch();
      batch.set(pathFS.doc(anotacao.id.toString()), {
        "userId": anotacao.userId,
        "titulo": anotacao.titulo,
        "descricao": anotacao.descricao,
        "data": anotacao.horaCriacao,
      });
      await batch.commit();
    } catch (e) {
      print(e);
    }
    print("Aqui em baixo");

    /*
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final anotacoesEmAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/DB/anotacao") && path.contains(".json"))
        .toList();
    List<Anotacao> anotacoes = [];
    for (var anotacao in anotacoesEmAssets) {
      String conteudoAnotacao = await rootBundle.loadString(anotacao);
      print(conteudoAnotacao);
      anotacoes.add(Anotacao.deJSON(json.decode(conteudoAnotacao)));
    }

    print(anotacoes.toString());
    
    

    for (var anotacao in anotacoes) {
      batch.set(pathFS.doc(anotacao.id.toString()), {
        "userId": anotacao.userId,
        "titulo": anotacao.titulo,
        "descricao": anotacao.descricao,
        "data": anotacao.horaCriacao,
      });
    }
    */*/
  }
}
