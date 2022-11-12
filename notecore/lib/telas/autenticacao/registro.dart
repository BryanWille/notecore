import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notecore/servicos/auth.dart';

class Registrar extends StatefulWidget {
  final Function mudarVisualizao;
  Registrar({required this.mudarVisualizao});

  //const Registrar({super.key});

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
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
            title: Text("Registrar no Notecore"),
            actions: <Widget>[
              ElevatedButton.icon(
                icon: Icon(Icons.person),
                label: Text("Logar"),
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
                      decoration: InputDecoration(
                          labelText: "Nome",
                          hintText: "Digite o seu nome",
                          border: OutlineInputBorder(borderSide: BorderSide())),
                      validator: (val) =>
                          val!.isEmpty ? "Insira o seu nome" : null,
                      onChanged: ((val) {
                        setState(() {});
                      })),
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "seuemail@email.com",
                          border: OutlineInputBorder(borderSide: BorderSide())),
                      validator: (val) =>
                          val!.isEmpty ? "Insira seu email" : null,
                      onChanged: ((val) {
                        setState(() {
                          email = val;
                        });
                      })),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Senha",
                        border: OutlineInputBorder(borderSide: BorderSide())),
                    validator: (val) => val!.length < 8
                        ? "Insira uma senha com mais de 8 dígitos"
                        : null,
                    obscureText: true,
                    onChanged: ((val) {
                      setState(() {
                        password = val;
                      });
                    }),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Confirmar senha",
                        border: OutlineInputBorder(borderSide: BorderSide())),
                    validator: (val) =>
                        val!.isEmpty ? "Insira a confirmação de senha" : null,
                    obscureText: true,
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
                      "Registrar",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result =
                            await _auth.registroComEmaileSenha(email, password);
                        if (result == null) {
                          setState(() {
                            erro = "por favor entre com um email valido!";
                          });
                        }
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
