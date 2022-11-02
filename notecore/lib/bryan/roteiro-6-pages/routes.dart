import 'package:flutter/material.dart';
import 'home_page.dart';
import 'anuncios_page.dart';
import 'dados_page.dart';
import 'favoritos_page.dart';

Map<String, WidgetBuilder> routes() {
  return {
    '/': (context) => HomePage(),
    '/anuncios': (context) => AnunciosPage(),
    '/dados': (context) => DadosPage(),
    '/favoritos': (context) => FavoritosPage(),
  };
}
