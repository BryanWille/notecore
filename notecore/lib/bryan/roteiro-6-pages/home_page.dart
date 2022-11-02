import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Layout Modelo'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'Home Page',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        drawer: SafeArea(
          child: Drawer(
              child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('seu nome e sobrenome'),
                accountEmail: Text("seuemail@email.com.br"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/bart.jpg'),
                ),
              ),
              ListTile(
                onTap: () {
                  print("Anúncios");
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/anuncios");
                },
                leading: const Icon(Icons.announcement),
                title: const Text("Anúncios"),
                subtitle: const Text("mais informações..."),
                trailing: const Icon(Icons.arrow_forward),
              ),
              ListTile(
                onTap: () {
                  print("Dados");
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/dados");
                },
                leading: const Icon(Icons.cloud),
                title: const Text("Dados"),
                subtitle: const Text("mais informações..."),
                trailing: const Icon(Icons.arrow_forward),
              ),
              ListTile(
                onTap: () {
                  print("Favoritos");
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/favoritos");
                },
                leading: const Icon(Icons.star),
                title: const Text("Favoritos"),
                subtitle: const Text("mais informações..."),
                trailing: const Icon(Icons.arrow_forward),
              ),
              ListTile(
                onTap: () {
                  print("Logout");
                },
                leading: const Icon(Icons.exit_to_app),
                title: const Text("Logout"),
                trailing: const Icon(Icons.arrow_forward),
              )
            ],
          )),
        ));
  }
}
