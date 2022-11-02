import 'package:flutter/material.dart';
import 'package:notecore/bryan/roteiro-5-pages/anuncios_page.dart';
import 'package:notecore/bryan/roteiro-5-pages/dados_page.dart';
import 'package:notecore/bryan/roteiro-5-pages/favoritos_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Layout Modelo'),
          centerTitle: true,
          bottom: TabBar(tabs: [
            Tab(icon: Icon(Icons.announcement)),
            Tab(icon: Icon(Icons.cloud)),
            Tab(icon: Icon(Icons.favorite))
          ]),
        ),
        body: TabBarView(
          children: [
            AnuncioPage(),
            DadosPage(),
            FavoritosPage(),
          ],
        ),
      ),
    );
  }
}
