import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Carregamento extends StatelessWidget {
  const Carregamento({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
            child: SpinKitChasingDots(
          color: Colors.blue[400],
          size: 30,
        )));
  }
}
