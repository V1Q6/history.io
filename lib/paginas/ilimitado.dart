import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../classes/pergunta.dart';
import '../widgets/caixaDialogo.dart';
import '../widgets/meutexto.dart';
import '../widgets/botoes.dart';

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

  @override
  void initState() {
    super.initState();
    obterPergunta();
  }

  Future<void> obterPergunta() async {
    var banco = FirebaseFirestore.instance.collection("pergunta");
    var query = await banco.count().get();
    int qtd = query.count!;
    var rnd = Random().nextInt(qtd);
    var docs = await banco.where("id", isEqualTo: rnd).get();

    setState(() {
      pergunta = Pergunta.fromSnapshot(docs.docs.first);
      pergunta.respostas.shuffle();
      qtdPergunta++;
    });
  }

  void responder(String resposta) async {
    if (vidas == 0) return; // evita responder após acabar o jogo

    bool correto = resposta == pergunta.respostaCorreta;

    if (correto) {
      qtdAcertos++;
      await showDialog(
        context: context,
        builder: (_) => CaixaDialogo(
          "Correto",
          "Você acertou!\n\n🔥 Você está com uma sequência de $qtdAcertos acertos!",
        ),
      );
      await obterPergunta();
    } else {
      setState(() => vidas--);
      await showDialog(
        context: context,
        builder: (_) => CaixaDialogo("Errado", "Você errou."),
      );

      if (vidas == 0) {
        await showDialog(
          context: context,
          builder: (_) => CaixaDialogo(
            "Fim de jogo",
            "Não foi desta vez 🤷‍♂️🤷‍♂️\n\nVocê acertou $qtdAcertos perguntas!",
          ),
        );
        // Reiniciar o jogo após fechar o diálogo de fim de jogo
        setState(() {
          vidas = 5;
          qtdAcertos = 0;
          qtdPergunta = 0;
        });
        await obterPergunta();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDead = vidas == 0;
    final larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: MeuTexto(
          texto: "Ilimitado",
          cor: Colors.white,
          tamanhoFonte: 20,
          negrito: FontWeight.bold,
        ),
        backgroundColor: Colors.lightBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: larguraTela < 500 ? double.infinity : 500,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                )
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MeuTexto(
                  texto: "Pergunta $qtdPergunta",
                  tamanhoFonte: 20,
                  cor: Colors.blue,
                  negrito: FontWeight.bold,
                ),
                const SizedBox(height: 12),
                MeuTexto(
                  texto: pergunta.pergunta,
                  tamanhoFonte: 16,
                  cor: Colors.black87,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    vidas,
                        (i) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: Text("❤️", style: TextStyle(fontSize: 24)),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Column(
                  children: pergunta.respostas.map((resposta) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: Botoes(
                          resposta,
                          corFundo: isDead
                              ? Colors.grey
                              : Colors.lightBlue.shade600,
                          onPressed: isDead ? null : () => responder(resposta),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
