import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Meu primeiro aplicativo, navbar!"),
            ),
            body: const Center(child: Text("Olá Mundo, Flutter!")))),
  );
}
