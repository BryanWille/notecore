import 'package:flutter/material.dart';
import './telas/calendario/calendario.dart';
import './telas/sobre/sobre.dart';
import './telas/autenticacao/login.dart';
import './logout.dart';
import './telas/wrapper.dart';
import 'main.dart';

Map<String, WidgetBuilder> rotas() {
  return {
    '/': (context) => Wrapper(),
    '/calendario': (context) => Calendario(),
    '/sobre': (context) => Sobre(),
    '/logout': (context) => Logout().telaDeLogin(),
  };
}
