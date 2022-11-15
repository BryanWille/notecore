import 'package:notecore/servicos/auth.dart';

class Logout {
  AuthServico _auth = AuthServico();
  telaDeLogin() async {
    await _auth.deslogar();
  }
}
