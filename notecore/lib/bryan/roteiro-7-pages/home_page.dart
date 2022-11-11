/*
import 'package:flutter/material.dart';
import 'anuncios_page.dart';
import 'dados_page.dart';
import 'favoritos_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  var _paginaAtual = 0;

  final List<Widget> _paginas = [
    const AnunciosPage(),
    const DadosPage(),
    const FavoritosPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout Modelo'),
        centerTitle: true,
      ),
      body: Container(
        child: _paginas.elementAt(_paginaAtual),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.announcement), label: 'Anúncios'),
          BottomNavigationBarItem(icon: Icon(Icons.cloud), label: 'Dados'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favoritos'),
        ],
        currentIndex: _paginaAtual,
        onTap: (int index) {
          setState(() {
            _paginaAtual = index;
          });
        },
      ),
    );
  }
}
*/
