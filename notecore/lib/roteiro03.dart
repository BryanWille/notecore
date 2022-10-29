// Layout modelo Básico - Stateless

import 'package:flutter/material.dart';

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Layout Modelo'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          color: Colors.amber,
          child: Column(children: [
            Row(
              children: [_texto("test 1", 22)],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            Row(
              children: [_texto("test 2", 22)],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            Row(
              children: [_texto("test 3", 22)],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ]),
        ));
  }

  Container _texto(String txt, double fontSize) {
    return Container(
      color: Colors.green,
      padding: EdgeInsets.all(16),
      child: Text(txt, style: TextStyle(fontSize: fontSize)),
      margin: EdgeInsets.only(top: 10, bottom: 30),
    );
  }
}
