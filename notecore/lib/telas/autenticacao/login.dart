import 'package:flutter/material.dart';
import 'package:notecore/servicos/auth.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final AuthServico _auth = AuthServico();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text("Entrar no NoteCore")),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: ElevatedButton(
            child: Text("Entrar sem login"),
            onPressed: () async {
              dynamic result = await _auth.logarAnonimo();
              if (result == null) {
                print('Erro ao entrar');
              } else {
                print("logou");
                print(result);
              }
            },
          )),
    );
  }
}
