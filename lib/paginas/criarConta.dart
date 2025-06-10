import 'package:aula/paginas/perfil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper.dart';
import '../widgets/botoes.dart';
import '../widgets/caixaDialogo.dart';
import '../widgets/meutexto.dart';
import '../widgets/widgetsInput.dart';

class CriarConta extends StatefulWidget {
  const CriarConta({super.key});

  @override
  State<CriarConta> createState() => _CriarContaState();
}

class _CriarContaState extends State<CriarConta> {
  var nomeController = TextEditingController();
  var emailController = TextEditingController();
  var senhaController = TextEditingController();
  late FirebaseAuth _auth;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    _initConta();

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
                Botoes("Fazer Login", onPressed: (){_criarConta();}),
                SizedBox(height: 100,),
              ],
            ),
          )
      ),
    );
  }

  Future<void> _initConta() async {
    _auth = FirebaseAuth.instance;
  }

  Future<void> _criarConta() async {
    var nome = nomeController.text;
    var email = emailController.text;
    var senha = senhaController.text;

    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: senha);

      if(mounted){
        abrirPagina(context, Perfil());
      }
    }catch(e){
      if(mounted){
        showDialog(
            context: context,
            builder: (BuildContext) => CaixaDialogo("Erro", "Esse email já está em uso.")
        );
      }
    }
  }
}

