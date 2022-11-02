import 'package:flutter/material.dart';

class AnuncioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.green,
            child: Center(
                child: Text(
              "Página de Anúncios",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ))));
  }
}
