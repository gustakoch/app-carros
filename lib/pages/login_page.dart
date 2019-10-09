import 'package:carros/pages/home_page.dart';
import 'package:carros/resources/alerts.dart';
import 'package:carros/resources/login_bloc.dart';
import 'package:carros/resources/nav.dart';
import 'package:carros/resources/usuario.dart';
import 'package:carros/services/api_response.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final bloc = LoginBloc();
  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();
  final _focusSenha = FocusNode();
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    Future<Usuario> usuario = Usuario.getUserFromPrefs();
    usuario.then((usuario) {
      if (usuario != null) {
        push(context, HomePage(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping de Carros'),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 90),
            Image.asset(
              'assets/images/logo.jpg',
              height: 70,
            ),
            SizedBox(height: 60),
            AppText(
              'Login',
              'Informe seu login de acesso',
              controller: _loginController,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 15),
            AppText(
              'Senha',
              'Informe sua senha de acesso',
              obscureText: true,
              controller: _senhaController,
              validator: _validateSenha,
              keyboardType: TextInputType.number,
              focusNode: _focusSenha,
            ),
            StreamBuilder<bool>(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  return snapshot.data ?? false
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : AppButton(
                          'LOGIN',
                          onPressed: _onClickLogin,
                        );
                }),
          ],
        ),
      ),
    );
  }

  void _onClickLogin() async {
    bool formStatus = _formKey.currentState.validate();
    if (!formStatus) return;

    String login = _loginController.text;
    String senha = _senhaController.text;

    ApiResponse response = await bloc.login(login, senha);

    if (response.isOk) {
      push(context, HomePage(), replace: true);
    } else {
      alertDialog(context, response.message);
    }
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return 'Digite o login de acesso a conta';
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return 'Digite a senha de acesso a conta';
    }
    if (text.length < 2) {
      return 'Sua senha deve possuir ao menos 3 dígitos numéricos';
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();

    bloc.dispose();
  }
}
