import 'package:carros/favoritos/carro-dao.dart';
import 'package:carros/resources/carro.dart';
import 'package:carros/resources/usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TipoCarro {
  static String classicos = "classicos";
  static String esportivos = "esportivos";
  static String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    Usuario usuario = await Usuario.getUserFromPrefs();

    Map<String, String> headers = {
      'Content-Type': "application/json",
      'Authorization': "Bearer ${usuario.token}"
    };

    var url = 'http://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';
    var response = await http.get(url, headers: headers);

    List list = json.decode(response.body);

    List<Carro> carros = list.map((item) => Carro.fromJson(item)).toList();

    // Salvar os carros no sqlite
    final dao = CarroDAO();
    carros.forEach((Carro carro) => dao.save(carro));

    return carros;
  }
}
