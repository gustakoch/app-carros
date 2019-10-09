import 'package:carros/resources/carro.dart';
import 'package:carros/services/api_carros.dart';
import 'dart:async';

class CarrosBloc {
  final streamController = StreamController<List<Carro>>();
  Stream<List<Carro>> get stream => streamController.stream;

  loadCarros(String tipo) async {
    try {
      List<Carro> carros = await CarrosApi.getCarros(tipo);

      streamController.add(carros);
    } catch (e) {
      streamController.addError(e);
    }
  }

  void dispose() {
    streamController.close();
  }
}
