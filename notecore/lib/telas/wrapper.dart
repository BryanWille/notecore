import 'package:flutter/material.dart';
import 'package:notecore/modelos/usuario.dart';
import 'package:notecore/telas/autenticacao/autenticacao.dart';
import 'package:notecore/telas/calendario/calendario.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<Usuario?>(context);
    print(usuario);
    //Retornar o Calendário ou o Autenticação
    if (usuario == null) {
      return Autenticacao();
    } else {
      return Calendario();
    }
  }
}
