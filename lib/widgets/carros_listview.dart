import 'package:carros/pages/carro_page.dart';
import 'package:carros/resources/carro.dart';
import 'package:carros/resources/carros_bloc.dart';
import 'package:carros/resources/nav.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

class CarrosListView extends StatefulWidget {
  String tipo;
  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  List<Carro> carros;

  String get tipo => widget.tipo;
  final bloc = CarrosBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    bloc.loadCarros(tipo);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: bloc.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return TextError('Não foi possível acessar os dados!');
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Carro> carros = snapshot.data;
        return _listView(carros);
      },
    );
  }

  Widget _listView(List<Carro> carros) {
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
                            onPressed: () => onClickCarro(carro),
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

  onClickCarro(Carro carro) {
    push(context, CarroPage(carro));
  }

  @override
  void dispose() {
    super.dispose();

    // bloc.dispose();
  }
}
