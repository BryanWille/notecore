import 'package:flutter/material.dart';
import 'package:notecore/telas/autenticacao/login.dart';

class Autenticacao extends StatefulWidget {
  const Autenticacao({super.key});

  @override
  State<Autenticacao> createState() => _AutenticacaoState();
}

class _AutenticacaoState extends State<Autenticacao> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LogIn(),
    );
  }
}
