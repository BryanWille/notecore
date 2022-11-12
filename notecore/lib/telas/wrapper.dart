import 'package:flutter/material.dart';
import 'package:notecore/telas/autenticacao/autenticacao.dart';
import 'package:notecore/telas/calendario/calendario.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //Retornar o Calendário ou o Autenticação
    return Autenticacao();
  }
}
