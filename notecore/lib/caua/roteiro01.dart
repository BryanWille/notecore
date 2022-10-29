import 'package:flutter/material.dart';

void roteiro01(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      primarySwatch: Colors.pink,
      ),
      home: Scafold(
        appBar: AppBar(
          title: const text('Meu primeiro Arquivo'),
        ),
        body: const Center(
          child: Text('Hello World Flutter!'),
        ),
      )
    ),
  );
}