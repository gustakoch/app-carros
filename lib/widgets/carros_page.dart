import 'package:carros/resources/carro.dart';
import 'package:carros/resources/carros_bloc.dart';
import 'package:carros/widgets/carros_listview.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

class CarrosPage extends StatefulWidget {
  String tipo;
  CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
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
        return RefreshIndicator(
          onRefresh: refreshCarrosListView,
          child: CarrosListView(carros),
        );
      },
    );
  }



  Future<void> refreshCarrosListView() {
    return bloc.loadCarros(tipo);
  }

  @override
  void dispose() {
    super.dispose();

    // bloc.dispose();
  }
}
