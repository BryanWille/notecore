import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notecore/compartilhada/carregamento.dart';
import 'package:notecore/servicos/auth.dart';
import './login.dart';

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
  bool _mostrarSenha = false;
  bool carregando = false;

  @override
  Widget build(BuildContext context) {
    return carregando
        ? Carregamento()
        : Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LogIn(
                              mudarVisualizao: widget.mudarVisualizao,
                            )),
                  );
                },
              ),
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
                          'lib/assets/images/cadastro.jpg',
                          height: 185,
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
                            border:
                                OutlineInputBorder(borderSide: BorderSide()),
                          ),
                          validator: (val) => val!.isEmpty
                              ? !val.contains('@')
                                  ? val.length < 7
                                      ? "Insira seu email"
                                      : "O e-mail deve ter um formato como email@seuemail.com"
                                  : "Formato de e-mail invalido"
                              : null,
                          onChanged: ((val) {
                            setState(() {
                              email = val;
                            });
                          })),
                      SizedBox(height: 12),
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
                                dynamic result = await _auth
                                    .registroComEmaileSenha(email, password);
                                setState(() {
                                  carregando = true;
                                });
                                if (result == null) {
                                  setState(() {
                                    carregando = false;
                                    erro =
                                        "por favor entre com um email valido!";
                                  });
                                } else {
                                  widget.mudarVisualizao();
                                }
                              }
                            }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(erro,
                          style: TextStyle(color: Colors.red, fontSize: 14))
                    ],
                  ),
                ),
              ),
            ));
  }
}
