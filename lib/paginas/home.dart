import 'package:aula/paginas/configuracoes.dart';
import 'package:aula/paginas/fatoDoDia.dart';
import 'package:aula/paginas/ilimitado.dart';
import 'package:aula/widgets/botoes.dart';
import 'package:aula/widgets/meutexto.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: MeuTexto(
            texto: "History.io",
            cor: Colors.white,
            tamanhoFonte: 20,
          ),
          actions: [
            IconButton(onPressed: (){_toPage(context, Configuracoes());}, icon: Icon(Icons.settings))
          ],
        ),
        body: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 100),
              MeuTexto(
                texto: "Bem-Vindo ao History.io!",
                tamanhoFonte: 48,
                negrito: FontWeight.bold,
              ),

              SizedBox(height: 100),
              MeuTexto(
                texto: "Vamos lá!",
                tamanhoFonte: 32,
              ),
              MeuTexto(
                texto: "Escolha o modo de jogo:",
                tamanhoFonte: 32,
              ),

              SizedBox(height: 100),
              ButtonTheme(
                height: 100,
                minWidth: 200,
                child: Botoes("FATO DO DIA", onPressed: (){_toPage(context, FatoDoDia());}),
              ),

              SizedBox(height: 20),
              ButtonTheme(
                height: 100,
                minWidth: 200,
                child: Botoes("ILIMITADO", onPressed: (){_toPage(context, Ilimitado());}),
              ),
            ],
          ),
        )
    );
  }

  _toPage(context, page){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){return page;}));
  }
}
