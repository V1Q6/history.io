import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../classes/pergunta.dart';
import '../widgets/botoes.dart';
import '../widgets/caixaDialogoErro.dart';
import '../widgets/meutexto.dart';

class Ilimitado extends StatefulWidget {
  const Ilimitado({super.key});

  @override
  State<Ilimitado> createState() => _IlimitadoState();
}

class _IlimitadoState extends State<Ilimitado> {
  int vidas = 5;
  int qtdAcertos = 0;
  int qtdPergunta = 0;
  Pergunta pergunta = Pergunta();
  late QuerySnapshot result;

  Future<void> obterPergunta() async {
    var banco = FirebaseFirestore.instance.collection("pergunta");
    AggregateQuerySnapshot query = await FirebaseFirestore.instance.collection('pergunta').count().get();
    int qtd = query.count!;
    var random = Random().nextInt(qtd);

    var consulta = await banco
        .where("id", isEqualTo: random);
    result = await consulta.get();

    setState(() {
      pergunta = Pergunta.fromSnapshot(result.docs[0]);
      pergunta.respostas.shuffle();
      qtdPergunta++;
    });
  }

  void responder(resposta){
    if(resposta == pergunta.respostaCorreta){
      showDialog(
          context: context,
          builder: (BuildContext) => CaixaDialogo("Correto", "Você acertou!")
      );
      obterPergunta();
      qtdAcertos++;
    }else{
      showDialog(
          context: context,
          builder: (BuildContext) => CaixaDialogo("Errado", "Você errou.")
      );
      setState(() {
        vidas--;
      });
    }

    if(vidas == 0){
      showDialog(
          context: context,
          builder: (BuildContext) => CaixaDialogo("Acabou o jogo", "Você acertou $qtdAcertos perguntas!")
      );
    }
  }

  @override
  void initState() {
    super.initState();
    obterPergunta();
  }

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
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                  height: 50
              ),
              Container(
                alignment: Alignment.center,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    MeuTexto(
                      texto: "Pergunta $qtdPergunta:",
                      tamanhoFonte: 20,
                    ),
                    SizedBox(height: 20),
                    MeuTexto(
                      texto: pergunta.pergunta,
                      tamanhoFonte: 16,
                    ),
                  ],
                ),
              ),
              SizedBox(height:10),
              Align(
                alignment: Alignment.centerLeft,
                child: MeuTexto(
                  texto: "Vidas: $vidas",
                  tamanhoFonte: 20,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Botoes(pergunta.respostas[0], onPressed: vidas > 0 ? (){responder(pergunta.respostas[0]);} : null),
                    SizedBox(height: 20),
                    Botoes(pergunta.respostas[1], onPressed: vidas > 0 ? (){responder(pergunta.respostas[1]);} : null),
                    SizedBox(height: 20),
                    Botoes(pergunta.respostas[2], onPressed: vidas > 0 ? (){responder(pergunta.respostas[2]);} : null),
                    SizedBox(height: 20),
                    Botoes(pergunta.respostas[3], onPressed: vidas > 0 ? (){responder(pergunta.respostas[3]);} : null),
                    SizedBox(height: 20),
                    Botoes(pergunta.respostas[4], onPressed: vidas > 0 ? (){responder(pergunta.respostas[4]);} : null),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
