import 'package:aula/paginas/estatisticas.dart';
import 'package:aula/widgets/botoes.dart';
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
    final screenSize = MediaQuery.of(context).size;

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
        padding: EdgeInsets.only(left: screenSize.width*0.05, top: screenSize.height*0.05, right: screenSize.width*0.05),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.sunny)),
                  MeuTexto(
                      texto: "Tema",
                      tamanhoFonte: 12
                  ),
                ],
              ),
            ),
            Botoes("Estatisticas", onPressed: (){_toPage(context, Estatisticas());})
          ],
        ),
      ),
    );
  }

  _toPage(context, page){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){return page;}));
  }
}
