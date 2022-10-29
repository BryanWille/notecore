// Layout modelo Básico - Stateless

import 'package:flutter/material.dart';
import 'roteiro-4-classes/pagina-inicial.dart';

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
