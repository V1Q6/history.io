import 'package:flutter/material.dart';

import '../widgets/meutexto.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: MeuTexto(
          texto: "Perfil",
          cor: Colors.white,
          tamanhoFonte: 20,
        ),
      ),
      body: Column(

      ),
    );
  }
}
