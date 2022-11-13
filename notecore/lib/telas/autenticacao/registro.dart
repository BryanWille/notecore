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
        appBar: AppBar(
          title: const Text('Cadastro'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: new Image.asset(
                      'cadastro.png',
                      width: 150,
                    ),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      hintText: 'Digite seu nome',
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? "Insira o seu nome" : null,
                    onChanged: ((val) {
                      setState(() {});
                    }),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Login',
                      hintText: 'Digite seu login',
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? "Insira o seu usuário" : null,
                    onChanged: ((val) {
                      setState(() {});
                    }),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        hintText: 'seuemail@email.com',
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
                      validator: (val) =>
                          val!.isEmpty ? "Insira seu email" : null,
                      onChanged: ((val) {
                        setState(() {
                          email = val;
                        });
                      })),
                  SizedBox(height: 12),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      hintText: 'Digite sua senha',
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                    validator: (val) => val!.length < 8
                        ? "Insira uma senha com mais de 8 dígitos"
                        : null,
                    onChanged: ((val) {
                      setState(() {
                        password = val;
                      });
                    }),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirmação de Senha',
                      hintText: 'Confirme sua senha',
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                    validator: (val) => val!.length < 8
                        ? "Insira uma senha com mais de 8 dígitos"
                        : null,
                    onChanged: ((val) {
                      setState(() {
                        password = val;
                      });
                    }),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                        child: Text('Cadastrar'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrangeAccent,
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            dynamic result = await _auth.registroComEmaileSenha(
                                email, password);
                            if (result == null) {
                              setState(() {
                                erro = "por favor entre com um email valido!";
                              });
                            }
                          }
                        }),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      child: Text('Fazer login'),
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
                    height: 20,
                  ),
                  Text(erro, style: TextStyle(color: Colors.red, fontSize: 14))
                ],
              ),
            ),
          ),
        ));
  }
}
