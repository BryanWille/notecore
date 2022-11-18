import 'dart:math';
import '../sidebar/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notecore/modelos/anotacao.dart';
import 'package:notecore/servicos/bancodedados.dart';
import 'package:notecore/telas/calendario/calendario.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class AdicionaNota extends StatefulWidget {
  @override
  _AdicionaNotaState createState() => _AdicionaNotaState();
}

class _AdicionaNotaState extends State<AdicionaNota> {
  List<IconTheme> list = [
    new IconTheme(
      data: new IconThemeData(color: Colors.blue),
      child: new Icon(Icons.circle),
    ),
    new IconTheme(
      data: new IconThemeData(color: Colors.yellow),
      child: new Icon(Icons.circle),
    ),
    new IconTheme(
      data: new IconThemeData(color: Colors.greenAccent),
      child: new Icon(Icons.circle),
    ),
  ];
  String titulo = "";
  String descricao = "";
  String hexCor = "";
  Color corTemp = Colors.blue;
  late Timestamp horaCriacao;
  final ServicoBD _bd = ServicoBD();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  IconTheme? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova nota'),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(240, 235, 227, 200),
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(top: 12.0, right: 60.0, left: 60.0, bottom: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (titulo == "" || descricao == "") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Não é possível enviar uma anotação sem descrição e/ou titulo"),
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        add();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (contex) => Calendario(),
                          ),
                        );
                      }
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
                        Colors.amber,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog();
        },
        backgroundColor: Color(0xFFF17532),
        child: Icon(Icons.color_lens),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void add() async {
    // Salvar no bd
    horaCriacao = Timestamp.now();
    if (hexCor == null || hexCor == "") {
      hexCor = "2196f3";
    }

    Anotacao nota = Anotacao(titulo, descricao, horaCriacao, hexCor,
        idNota: DateTime.now().microsecondsSinceEpoch.toString());
    _bd.criarNota(nota);
  }

  void _showDialog() {
    const snackBar = SnackBar(
      content: Text('Anotação deletada com sucesso'),
    );
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alterar cor da nota"),
          content: SelectionArea(
              child: MaterialColorPicker(
                  onColorChange: (Color color) {
                    corTemp = color;
                  },
                  selectedColor: Colors.blue)),
          actions: <Widget>[
            new ElevatedButton(
              child: new Text("Salvar"),
              onPressed: () {
                Navigator.of(context).pop();
                hexCor = corTemp.value.toRadixString(16).substring(2);
              },
            ),
            new ElevatedButton(
              child: new Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
