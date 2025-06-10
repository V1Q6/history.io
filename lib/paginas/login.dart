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

        child: Container(
          constraints: BoxConstraints(maxHeight: screenSize.height*0.7, maxWidth: screenSize.width*0.8),
          width: 500,
          height: 700,
          child: Column(
            children: [
              InputTextos("email", "email", controller: emailController),
              InputTextos("senha", "senha", controller: senhaController),
              Botoes("Fazer Login", onPressed: (){_fazerLogin();}),
              SizedBox(height: 100,),
              Botoes("Não tenho uma conta", onPressed: abrirPagina(context, CriarConta()))
            ],
          ),
        )
      ),
    );
  }

  _initLogin(){
    _auth = FirebaseAuth.instance;
  }

  Future<void> _fazerLogin() async{
    var email = emailController.text;
    var senha = senhaController.text;
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: senha);

      if(mounted){
        abrirPagina(context, Perfil());
      }
    }catch(e){
      if(mounted){
        showDialog(
            context: context,
            builder: (BuildContext) => CaixaDialogo("Erro", "Email ou senha não correspondem.")
        );
      }
    }
  }
}
