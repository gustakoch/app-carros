import 'package:carros/resources/usuario.dart';
import 'package:carros/services/api_login.dart';
import 'package:carros/services/api_response.dart';
import 'dart:async';

class LoginBloc {
  final streamController = StreamController<bool>();

  Stream get stream => streamController.stream;

  Future<ApiResponse<Usuario>> login(String login, String senha) async {
    streamController.add(true);

    ApiResponse response = await LoginApi.login(login, senha);

    streamController.add(false);

    return response;
  }

  void dispose() {
    streamController.close();
  }
}
