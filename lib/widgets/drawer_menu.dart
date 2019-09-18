import 'package:carros/pages/login_page.dart';
import 'package:carros/resources/nav.dart';
import 'package:carros/resources/usuario.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  _header(Usuario usuario) {
    return UserAccountsDrawerHeader(
      accountName: Text(usuario.nome),
      accountEmail: Text(usuario.email),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(usuario.urlFoto),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<Usuario>(
              future: Usuario.getUserFromPrefs(),
              builder: (context, snapshot) {
                Usuario usuario = snapshot.data;
                return usuario != null ? _header(usuario) : Container();
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favoritos'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              onTap: () => _onClickLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  _onClickLogout(context) {
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
