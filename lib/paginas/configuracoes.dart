import 'package:flutter/material.dart';

import '../widgets/meutexto.dart';

class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: MeuTexto(
          texto: "Configurações",
          cor: Colors.white,
          tamanhoFonte: 20,
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        alignment: Alignment.center,
        child: Column(
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.sunny)),
            MeuTexto(
              texto: "Tema",
              tamanhoFonte: 12
            ),

          ],
        ),
      ),
    );
  }
}
