import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("Meu primeiro app!"),
        ),
        body: const Center(
          child: const Text("Hello Flutter!"),
        ),
      )),
  );
}