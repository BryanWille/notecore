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
  String email = '';
  String password = '';

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
              child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(onChanged: ((val) {
                setState(() {
                  email = val;
                });
              })),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                onChanged: ((val) {
                  setState(() {
                    password = val;
                  });
                }),
              ),
              TextFormField(
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
                  backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                ),
                child: Text(
                  "Registrar",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  print(email + "\n" + password);
                },
              )
            ],
          )),
        ));
  }
}
