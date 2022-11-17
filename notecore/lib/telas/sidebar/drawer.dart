import 'package:flutter/material.dart';
import '../../servicos/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../calendario/calendario.dart';
import '../sobre/sobre.dart';
import '../anotacoes/adicionar_notas.dart';
import '../../main.dart';

class MenuDrawer extends StatelessWidget {
  MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text(''),
            accountEmail: Text('seuemail@mail.com'),
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
                AuthServico _auth = AuthServico();
                _auth.deslogar();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => MyApp(),
                    ));
              }),
        ],
      ),
    );
  }
}
