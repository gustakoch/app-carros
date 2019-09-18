import 'package:carros/resources/usuario.dart';
import 'package:carros/services/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginApi {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    try {
      var url = 'http://carros-springboot.herokuapp.com/api/v2/login';
      var headers = {"Content_Type": "application/json"};
      var params = {"username": login, "password": senha};

      String paramsString = json.encode(params);

      var response = await http.post(url, body: paramsString, headers: headers);

      Map responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        final usuario = Usuario.fromJson(responseJson);

        usuario.salvarDados();

        return ApiResponse.isOk(usuario);
      }
      return ApiResponse.error(responseJson['error']);
    } catch (error, exception) {
      print('Erro ao realizar o login! Erro: $error | Exception: $exception');

      return ApiResponse.error(
          'Não foi possível fazer o login! Verifique sua conexão e tente novamente mais tarde.');
    }
  }
}
