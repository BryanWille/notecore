import 'package:notecore/servicos/auth.dart';
import 'package:notecore/servicos/bancodedados.dart';
import 'package:flutter/material.dart';
import 'package:notecore/telas/anotacoes/editar_notas.dart';
import '../sidebar/drawer.dart';

class VisualizarAnotacao extends StatefulWidget {
  VisualizarAnotacao({Key? key, required this.idNota}) : super(key: key);
  String idNota;

  @override
  State<VisualizarAnotacao> createState() =>
      VisualizarAnotacaoState(idNota: idNota);
}

class VisualizarAnotacaoState extends State<VisualizarAnotacao> {
  AuthServico _auth = AuthServico();
  ServicoBD _bd = ServicoBD();
  List<Map<String, dynamic>> nota = [];
  String idNota;
  Map<String, dynamic> anotacao = {};

  VisualizarAnotacaoState({required this.idNota});

  @override
  void initState() {
    lerUmaNota();
    super.initState();
  }

  void lerUmaNota() {
    _bd.retornaNota(idNota).then((lista) {
      setState(() {
        nota.add(lista);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: MenuDrawer(),
      ),
      appBar: AppBar(title: Text("Olá mundo")),
      body: Stack(children: <Widget>[
        ListView?.builder(
            itemCount: nota.length,
            itemBuilder: (context, index) {
              anotacao = nota[0];
              return Container(
                child: Text(anotacao["descricao"]),
              );
            }),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (contex) => EditarAnotacao(
                idNota: idNota,
              ),
            ),
          );
        },
        child: const Icon(Icons.mode_edit),
      ),
    );
  }
}
