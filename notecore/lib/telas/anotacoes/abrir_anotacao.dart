import 'package:flutter/material.dart';

main() => runApp(const AbreNota());

class AbreNota extends StatelessWidget {
  const AbreNota({Key? key}) : super(key: key);

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
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: SafeArea(
        child: Drawer(),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: SizedBox(
            height: 300,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(240, 235, 227, 200),
                border: Border.all(
                  color: Color.fromARGB(240, 235, 227, 200),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
