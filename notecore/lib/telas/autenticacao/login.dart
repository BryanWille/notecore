import 'package:flutter/material.dart';
import 'package:notecore/servicos/auth.dart';

class LogIn extends StatefulWidget {
  final Function mudarVisualizao;
  LogIn({required this.mudarVisualizao});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final AuthServico _auth = AuthServico();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String erro = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            title: Text("Entrar no Notecore"),
            actions: <Widget>[
              ElevatedButton.icon(
                icon: Icon(Icons.person),
                label: Text("Registrar"),
                onPressed: () {
                  widget.mudarVisualizao();
                },
              )
            ]),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Insira o seu email" : null,
                      onChanged: ((val) {
                        setState(() {
                          email = val;
                        });
                      })),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    validator: (val) => val!.length < 8
                        ? "Insira uma senha com mais de 8 dígitos"
                        : null,
                    onChanged: ((val) {
                      setState(() {
                        password = val;
                      });
                    }),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrange),
                    ),
                    child: Text(
                      "Logar",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        /*dynamic result =
                            await _auth.registroComEmaileSenha(email, password);
                        if (result == null) {
                          setState(() {
                            erro = "por favor entre com um email valido!";
                          });
                        }*/
                        print("valido");
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(erro, style: TextStyle(color: Colors.red, fontSize: 14))
                ],
              )),
        ));
  }
}
