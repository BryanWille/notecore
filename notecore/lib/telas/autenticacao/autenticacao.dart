import 'package:flutter/material.dart';
import 'package:notecore/telas/autenticacao/login.dart';
import 'package:notecore/telas/autenticacao/registro.dart';

class Autenticacao extends StatefulWidget {
  const Autenticacao({super.key});

  @override
  State<Autenticacao> createState() => _AutenticacaoState();
}

class _AutenticacaoState extends State<Autenticacao> {
  bool mostrarLogin = true;
  void mudarEntrada() {
    setState(() => mostrarLogin = !mostrarLogin);
  }

  @override
  Widget build(BuildContext context) {
    if (mostrarLogin) {
      return LogIn(mudarVisualizao: mudarEntrada);
    } else {
      return Registrar(mudarVisualizao: mudarEntrada);
    }
  }
}
