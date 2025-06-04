import 'package:flutter/material.dart';

import '../widgets/meutexto.dart';

class Estatisticas extends StatefulWidget {
  const Estatisticas({super.key});

  @override
  State<Estatisticas> createState() => _EstatisticasState();
}

class _EstatisticasState extends State<Estatisticas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: MeuTexto(
          texto: "Estatisticas",
          cor: Colors.white,
          tamanhoFonte: 20,
        ),
      ),
      body: Column(

      ),
    );
  }
}
