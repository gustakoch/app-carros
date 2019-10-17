import 'package:carros/pages/carro_page.dart';
import 'package:carros/resources/carro.dart';
import 'package:carros/resources/nav.dart';
import 'package:flutter/material.dart';

class CarrosListView extends StatelessWidget {
  List<Carro> carros;
  CarrosListView(this.carros);

  @override
  Widget build(BuildContext context) {
    return _listView(carros);
  }

  _listView(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros.length,
        itemBuilder: (BuildContext context, int index) {
          Carro carro = carros[index];

          return Container(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Card(
              color: Colors.grey[100],
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image.network(
                        carro.urlFoto ??
                            'http://casadascapotas.com/images/sem_foto.png',
                        width: 230,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      carro.nome,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Descrição do veículo...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[500],
                      ),
                    ),
                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('DETALHES'),
                            onPressed: () => onClickCarro(context, carro),
                          ),
                          FlatButton(
                            child: const Text('SHARE'),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  onClickCarro(context, Carro carro) {
    push(context, CarroPage(carro));
  }
}
