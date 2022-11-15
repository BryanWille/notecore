import 'package:flutter/material.dart';
import '../../servicos/auth.dart';
import '../../logout.dart';

class MenuDrawer extends StatelessWidget {
  
  const MenuDrawer({Key? key}) : super(key: key);

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
              Navigator.pushNamed(context, "/calendario");
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("Sobre"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Logout"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                AuthServico _auth = AuthServico();
                Navigator.pop(context);
                _auth.deslogar();
              }),
        ],
      ),
    );
  }
}
