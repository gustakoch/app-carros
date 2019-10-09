import 'package:carros/resources/carro.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatelessWidget {
  Carro carro;
  CarroPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: onClickMapa,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: onClickVideo,
          ),
          PopupMenuButton<String>(
            onSelected: onClickMenuPopup,
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: 'Editar', child: Text('Editar')),
                PopupMenuItem(value: 'Excluir', child: Text('Excluir')),
                PopupMenuItem(value: 'Share', child: Text('Share')),
              ];
            },
          ),
        ],
      ),
      body: body(),
    );
  }

  body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Image.network(carro.urlFoto),
    );
  }

  void onClickMapa() {}

  void onClickVideo() {}

  onClickMenuPopup(String valor) {
    switch (valor) {
      case "Editar":
        print('Clicou no Editar!');
        break;
      case "Excluir":
        print('Clicou no Excluir!');
        break;
      case "Share":
        print('Clicou no Share!');
        break;
    }
  }
}
