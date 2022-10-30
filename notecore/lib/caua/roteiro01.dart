import 'package:flutter/material.dart';

void roteiro01(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Meu primeiro Arquivo'),
        ),
        body: const Center(
          child: Text('Hello World Flutter!'),
        ),
      )
    ),
  );
}