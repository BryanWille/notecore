import 'package:flutter/material.dart';
import 'pagina-voltar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomePage'),
          centerTitle: true,
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ArquivosPage(),
                  ));
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(8),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: SizedBox(
              width: 300,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Botão 05'),
                  SizedBox(width: 8),
                  Icon(Icons.save),
                ],
              ),
            ),
          ),
        ));
  }
}
