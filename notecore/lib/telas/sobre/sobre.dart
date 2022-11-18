import 'package:flutter/material.dart';
import '../sidebar/drawer.dart';

class Sobre extends StatelessWidget {
  const Sobre({Key? key}) : super(key: key);

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
            new Image.asset("lib/assets/images/sobre.png", height: 250,),
            Text(
                'O objetivo era desenvolver uma aplicação com os conhecimentos adquiridos durante o semestre.\n\n\n\n\n\n\n'),
            Text('Todos os direitos reservados aos criadores.'),
          ],
        ),
      ),
      drawer: SafeArea(
        child: MenuDrawer(),
      ),
    );
  }
}
