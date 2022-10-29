import 'package:flutter/material.dart';

class ArquivosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de AArquivos'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.redAccent,
        child: Center(
          child: ElevatedButton(
            
            onPressed: () {
              Navigator.pop(context);
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              elevation: 9,
              padding: const EdgeInsets.all(8),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: SizedBox(
              width: 150,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Voltar'),
                  SizedBox(width: 15),
                  Icon(Icons.arrow_back_outlined),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
