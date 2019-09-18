import 'package:carros/resources/carro.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TipoCarro {
  static String classicos = "classicos";
  static String esportivos = "esportivos";
  static String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    var url = 'http://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo';
    var response = await http.get(url);

    List list = json.decode(response.body);

    final carros = list.map((item) => Carro.fromJson(item)).toList();

    return carros;
  }
}
