import 'package:flutter/material.dart';

main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            Text(
                'Notecore foi desenvolvido para um trabalho acadêmico da matéria de Desenvolvimento para Dispositivos Móveis, do curso de Ciências da Computação, pela faculdade Dom Helder Câmara.'),
            new Image.asset("lib/assets/images/sobre.png"),
            Text(
                'O objetivo era desenvolver uma aplicação com os conhecimentos adquiridos durante o semestre.\n\n\n\n\n\n\n'),
            Text('Todos os direitos reservados aos criadores.'),
          ],
        ),
      ),
    );
  }
}
