import 'package:flutter/material.dart';
import 'roteiro-6-pages/home_page.dart';
import 'roteiro-6-pages/anuncios_page.dart';
import 'roteiro-6-pages/dados_page.dart';
import 'roteiro-6-pages/favoritos_page.dart';
import 'roteiro-6-pages/routes.dart';

// *********************************
//
// Layout Modelo Básico - STATELESS
//
// *********************************

main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: routes(),
    );
  }
}
