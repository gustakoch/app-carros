class Usuario {
  String login;
  String nome;
  String email;
  String token;

  List<String> roles;

  Usuario.fromJson(Map<String, dynamic> map) {
    this.login = map['login'];
    this.nome = map['nome'];
    this.email = map['email'];
    this.token = map['token'];
    this.roles = map['roles'] != null
        ? map['roles'].map<String>((role) => role.toString()).toList()
        : null;
  }

  @override
  String toString() {
    return 'Usuario(login: $login, nome: $nome, email: $email, token: $token, roles: $roles)';
  }
}
