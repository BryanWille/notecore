import 'dart:math';
import '../sidebar/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notecore/modelos/anotacao.dart';
import 'package:notecore/servicos/bancodedados.dart';
import 'package:notecore/telas/calendario/calendario.dart';

class AdicionaNota extends StatefulWidget {
  @override
  _AdicionaNotaState createState() => _AdicionaNotaState();
}

class _AdicionaNotaState extends State<AdicionaNota> {
  late String titulo;
  late String descricao;
  late Timestamp horaCriacao;
  final ServicoBD _bd = ServicoBD();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sobre'),
          centerTitle: true,
        ),
        backgroundColor: Color.fromARGB(240, 235, 227, 200),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                top: 12.0, right: 60.0, left: 60.0, bottom: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        add();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (contex) => Calendario(),
                          ),
                        );
                      },
                      child: Text(
                        "Salvar",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "lato",
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.blue,
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 10.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //
                SizedBox(
                  height: 12.0,
                ),
                //
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: "Titulo",
                        ),
                        style: TextStyle(
                          fontSize: 32.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        onChanged: (_val) {
                          titulo = _val;
                        },
                      ),
                      Divider(
                        color: Colors.black,
                        height: 20,
                        thickness: 2,
                        indent: 10,
                        endIndent: 10,
                      ),
                      //
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        padding: const EdgeInsets.only(top: 12.0),
                        child: TextFormField(
                          decoration: InputDecoration.collapsed(
                            hintText: "Escreva aqui...",
                            
                          ),
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "lato",
                          ),
                          maxLines: 20,
                          onChanged: (_val) {
                            descricao = _val;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: SafeArea(
          child: MenuDrawer(),
        ),
      ),
    );
  }

  void add() async {
    // Salvar no bd
    horaCriacao = Timestamp.now();
    Anotacao nota = Anotacao(titulo, descricao, horaCriacao);
    _bd.criarNota(nota);
  }
}