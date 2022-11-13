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
      appBar: AppBar(
        title: const Text('Entrar no Notecore'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  child: Image.asset(
                    "lib/assets/images/cadastro.png",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
