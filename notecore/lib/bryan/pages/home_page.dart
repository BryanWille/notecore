import 'package:flutter/material.dart';
import 'package:notecore/bryan/pages/anuncios_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout Modelo'),
        centerTitle: true,
      ),
      body: AnuncioPage(),
    );
  }
}
