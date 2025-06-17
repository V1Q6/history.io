import 'package:aula/paginas/criarConta.dart';
import 'package:aula/paginas/perfil.dart';
import 'package:aula/widgets/botoes.dart';
import 'package:aula/widgets/caixaDialogo.dart';
import 'package:aula/widgets/widgetsInput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aula/helper.dart';

import '../widgets/meutexto.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();
  var senhaController = TextEditingController();
  late FirebaseAuth _auth;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    _initLogin();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: MeuTexto(
          texto: "Login",
          cor: Colors.white,
          tamanhoFonte: 20,
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: screenSize.height * 0.8,
              maxWidth: screenSize.width * 0.9,
            ),
            width: 400,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputTextos("Email", "Digite seu email", controller: emailController),
                const SizedBox(height: 16),
                InputTextos("Senha", "Digite sua senha", controller: senhaController),
                const SizedBox(height: 32),
                Botoes(
                  "Fazer Login",
                  onPressed: _fazerLogin,
                  corFundo: Colors.blue,
                ),
                const SizedBox(height: 24),
                Botoes(
                  "Não tenho uma conta",
                  onPressed: () {
                    abrirPagina(context, const CriarConta());
                  },
                  corFundo: Colors.grey.shade300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _initLogin() {
    _auth = FirebaseAuth.instance;
  }

  Future<void> _fazerLogin() async {
    var email = emailController.text;
    var senha = senhaController.text;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: senha);

      if (mounted) {
        abrirPagina(context, const Perfil());
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext) =>
              CaixaDialogo("Erro", "Email ou senha não correspondem."),
        );
      }
    }
  }
}
