import 'package:flutter/material.dart';

void main() => runApp(const myApp());

class myApp extends StatelessWidget{
  const myApp({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Layout modelo"),
      centerTitle: true,),
      body: const Center(
        child: Text("Comece aqui!")
      ),
    );
  }
}