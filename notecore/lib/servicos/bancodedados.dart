import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notecore/modelos/anotacao.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  Future<void> uploadData() async {
    final fireStore = FirebaseFirestore.instance;
    final pathFS = fireStore.collection("anotacoes");
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
    */
  }
}
