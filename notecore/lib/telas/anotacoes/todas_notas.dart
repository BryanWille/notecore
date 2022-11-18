import 'package:notecore/modelos/anotacao.dart';
import 'package:notecore/servicos/bancodedados.dart';
import 'package:flutter/material.dart';
import 'package:notecore/telas/anotacoes/editar_notas.dart';
import '../sidebar/drawer.dart';

class TodasNotas extends StatefulWidget {
  const TodasNotas({Key? key}) : super(key: key);

  @override
  State<TodasNotas> createState() => _TodasNotasState();
}

class _TodasNotasState extends State<TodasNotas> {
  ServicoBD _bd = ServicoBD();
  List<Map<String, dynamic>> _listaAnotacao = [];
  Anotacao? anotacaoSelecionada;
  Color cor = Colors.blue;

  @override
  void initState() {
    super.initState();
    atualizarListaNotas();
  }

  void atualizarListaNotas() {
    _bd.retornaNotas().then((lista) {
      setState(() {
        _listaAnotacao = lista;
      });
    });
  }

  void deletarNota() {
    _bd.deletarNota(anotacaoSelecionada!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Lista das Anotações'), centerTitle: true),
          drawer: SafeArea(child: MenuDrawer()),
      body: ListView.builder(
        itemCount: _listaAnotacao.length,
        itemBuilder: (context, index) {
          cor = Color(converterCor(_listaAnotacao[index]['hexCor']));
          return Dismissible(
            key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
            direction: DismissDirection.startToEnd,
            background: Container(
              color: Colors.red,
              child: const Align(
                alignment: Alignment(-0.9, 0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            onDismissed: (direcao) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (inContext) {
                  return WillPopScope(
                    onWillPop: () async => false,
                    child: AlertDialog(
                      title: Text('Deseja mesmo excluir essa anotação?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(inContext);
                            atualizarListaNotas();
                          },
                          child: Text('Não'),
                        ),
                        TextButton(
                          onPressed: () {
                            anotacaoSelecionada =
                                Anotacao.deDicionario(_listaAnotacao[index]);
                            deletarNota();
                            Navigator.pop(inContext);
                          },
                          child: Text('Sim'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: ListTile(
              leading: const Icon(
                Icons.book,
                color: Colors.amber,
                size: 25,
              ),
              title: Text(_listaAnotacao[index]['titulo']),
              subtitle: Text('${_listaAnotacao[index]['titulo']}'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                String idNota = _listaAnotacao[index]['idNota'];
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          EditarAnotacao(idNota: idNota),
                    ));
              },
            ),
          );
        },
      ),
    );
  }

  int converterCor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
