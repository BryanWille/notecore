import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notecore/compartilhada/carregamento.dart';
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
  bool _mostrarSenha = false;
  bool carregando = false;

  @override
  Widget build(BuildContext context) {
    return carregando
        ? Carregamento()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Entrar no Notecore'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        child: new Image.asset(
                          "lib/assets/images/cadastro.jpg",
                          height: 185,
                        ),
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        autofocus: true,
                        validator: (val) =>
                            val!.isEmpty ? "Insira o seu email" : null,
                        onChanged: ((val) {
                          setState(() {
                            email = val;
                          });
                        }),
                        decoration: InputDecoration(
                          labelText: 'Login',
                          hintText: 'Digite seu login',
                          border: OutlineInputBorder(borderSide: BorderSide()),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        obscureText: _mostrarSenha == false ? true : false,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            child: Icon(
                              _mostrarSenha == false
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Color.fromARGB(255, 35, 55, 168),
                            ),
                            onTap: () {
                              setState(() {
                                _mostrarSenha = !_mostrarSenha;
                              });
                            },
                          ),
                          labelText: 'Senha',
                          hintText: 'Digite sua senha',
                          border: OutlineInputBorder(borderSide: BorderSide()),
                        ),
                        validator: (val) => val!.length < 6
                            ? "Insira uma senha com mais de 6 dígitos"
                            : null,
                        onChanged: ((val) {
                          setState(() {
                            password = val;
                          });
                        }),
                      ),
                      SizedBox(height: 12),
                      Text(erro,
                          style: TextStyle(color: Colors.red, fontSize: 14)),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          child: Text('Entrar'),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrangeAccent,
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                carregando = true;
                              });
                              dynamic result = await _auth.loginComEmailESenha(
                                  email, password);
                              if (result == null) {
                                setState(() {
                                  carregando = false;
                                  erro =
                                      "Email ou senha não digitados corretamente!";
                                });
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          child: Text('Criar conta'),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrangeAccent,
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          onPressed: () {
                            widget.mudarVisualizao();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          child: Text('Login Anônimo'),
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 1, 22, 33),
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          onPressed: () {
                            _auth.logarAnonimo();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
