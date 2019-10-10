import 'package:carros/resources/carro.dart';
import 'package:carros/services/api_loripsum.dart';
import 'package:carros/widgets/text_custom.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatefulWidget {
  Carro carro;
  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final bloc = LoripsumBloc();

  @override
  void initState() {
    super.initState();

    bloc.loadCarros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
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
      child: ListView(
        children: <Widget>[
          Image.network(widget.carro.urlFoto),
          SizedBox(height: 10),
          session1(),
          Divider(),
          session2(),
        ],
      ),
    );
  }

  session1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextCustom(widget.carro.nome, bold: true, fontSize: 20),
            TextCustom(widget.carro.tipo, fontSize: 16),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite, color: Colors.red, size: 35),
              onPressed: onClickFavorite,
            ),
            IconButton(
              icon: Icon(Icons.share, size: 35),
              onPressed: onClickShare,
            ),
          ],
        ),
      ],
    );
  }

  session2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        TextCustom(widget.carro.descricao),
        StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return TextCustom(snapshot.data);
          },
        ),
      ],
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

  void onClickFavorite() {}

  void onClickShare() {}

  @override
  void dispose() {
    super.dispose();

    bloc.dispose();
  }
}
