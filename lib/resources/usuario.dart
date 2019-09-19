import 'package:carros/resources/prefs.dart';
import 'dart:convert';

class Usuario {
  int id;
  String login;
  String nome;
  String email;
  String urlFoto;
  String token;
  List<String> roles;

  Usuario({
    this.id,
    this.login,
    this.nome,
    this.email,
    this.urlFoto,
    this.token,
    this.roles,
  });

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    nome = json['nome'];
    email = json['email'];
    urlFoto = json['urlFoto'];
    token = json['token'];
    roles = json['roles'] != null ? json['roles'].cast<String>() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['urlFoto'] = this.urlFoto;
    data['token'] = this.token;
    data['roles'] = this.roles;
    return data;
  }

  @override
  String toString() {
    return 'Usuario{login: $login, nome: $nome, email: $email, urlFoto: $urlFoto, token: $token, roles: $roles}';
  }

  void salvarDados() {
    Map map = toJson();
    String jsonObject = json.encode(map);

    Prefs.setString('usuario', jsonObject);
  }

  static Future<Usuario> getUserFromPrefs() async {
    String jsonString = await Prefs.getString('usuario');
    if (jsonString.isEmpty) {
      return null;
    }

    Map map = json.decode(jsonString);
    Usuario usuario = Usuario.fromJson(map);

    return usuario;
  }

  static void clear() {
    Prefs.setString('usuario', '');
  }
}
