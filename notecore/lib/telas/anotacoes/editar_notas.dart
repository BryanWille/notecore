import 'package:notecore/modelos/anotacao.dart';
import 'package:notecore/servicos/auth.dart';
import 'package:notecore/servicos/bancodedados.dart';
import 'package:flutter/material.dart';
import 'package:notecore/telas/calendario/calendario.dart';
import '../sidebar/drawer.dart';

class EditarAnotacao extends StatefulWidget {
  EditarAnotacao({Key? key, required this.idNota}) : super(key: key);
  String idNota;

  @override
  State<EditarAnotacao> createState() => EditarAnotacaoState(idNota: idNota);
}

class EditarAnotacaoState extends State<EditarAnotacao> {
  AuthServico _auth = AuthServico();
  ServicoBD _bd = ServicoBD();
  List<Map<String, dynamic>> nota = [];
  String idNota;
  Map<String, dynamic> anotacao = {};

  EditarAnotacaoState({required this.idNota});

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
              return SingleChildScrollView(
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
                              atualizarNota();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (contex) => Calendario(),
                                ),
                              );
                            },
                            child: Text(
                              "Salvar edição",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "lato",
                                color: Colors.black,
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
                              initialValue: anotacao['titulo'],
                              style: TextStyle(
                                fontSize: 32.0,
                                fontFamily: "lato",
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              onChanged: (_val) {
                                anotacao['titulo'] = _val;
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
                                initialValue: anotacao['descricao'],
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "lato",
                                ),
                                maxLines: 20,
                                onChanged: (_val) {
                                  anotacao['descricao'] = _val;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          _showDialog();
        },
        child: const Icon(Icons.delete),
      ),
    );
  }

  void atualizarNota() {
    Anotacao editarNota = Anotacao.deDicionario(anotacao);
    _bd.atualizarNota(editarNota);
  }

  void deletarNota() {
    Anotacao deletarNota = Anotacao.deDicionario(anotacao);
    _bd.deletarNota(deletarNota);
  }

  void _showDialog() {
    const snackBar = SnackBar(
      content: Text('Anotação deletada com sucesso'),
    );
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Deseja remover essa anotação?"),
          content: new Text("Tem certeza que deseja remover essa anotação?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new ElevatedButton(
              child: new Text("Sim"),
              onPressed: () {
                deletarNota();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (contex) => Calendario(),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
            new ElevatedButton(
              child: new Text("Não"),
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
