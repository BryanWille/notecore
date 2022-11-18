import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notecore/telas/anotacoes/todas_notas.dart';
import 'package:notecore/servicos/bancodedados.dart';
import '../../servicos/auth.dart';
import '../calendario/calendario.dart';
import '../sobre/sobre.dart';
import '../anotacoes/adicionar_notas.dart';
import '../../main.dart';

class MenuDrawer extends StatelessWidget {
  MenuDrawer({Key? key}) : super(key: key);
  FirebaseAuth _auth = FirebaseAuth.instance;
  ServicoBD _bd = ServicoBD();

  @override
  Widget build(BuildContext context) {
    String emailUsuario = "Email não cadastrado";
    String nomeUsuario = "Noma não cadastrado";
    try {
      nomeUsuario = _auth.currentUser!.displayName!;
      emailUsuario = _auth.currentUser!.email!;
    } catch (e) {
      print(e);
    }
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(nomeUsuario),
            accountEmail: Text(emailUsuario),
            currentAccountPicture: CircleAvatar(
              backgroundImage:
                  AssetImage('lib/assets/images/Notebook-pana.png'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.event),
            title: const Text("Calendário"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Calendario(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.post_add),
            title: const Text("Criar nota"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => AdicionaNota(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_alt_sharp),
            title: const Text("Lista de Anotações"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => TodasNotas(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("Sobre"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Sobre(),
                  ));
            },
          ),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Logout"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                AuthServico _logout = AuthServico();
                _logout.deslogar();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyApp()));
              }),
        ],
      ),
    );
  }
}
