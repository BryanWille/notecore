/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class AnotacoesLista extends StatefulWidget {
  const AnotacoesLista({super.key});

  @override
  State<AnotacoesLista> createState() => _AnotacoesListaState();
}

class _AnotacoesListaState extends State<AnotacoesLista> {
  @override
  Widget build(BuildContext context) {
    final anotacoes = Provider.of<QuerySnapshot>(context);
    for (var doc in anotacoes.docs) {
      print(doc.data);
    }
    return Container();
  }
}
*/