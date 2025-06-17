import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aula/classes/pergunta.dart';
import 'package:aula/widgets/caixaDialogo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/botoes.dart';
import '../widgets/meutexto.dart';

class FatoDoDia extends StatefulWidget {
  const FatoDoDia({super.key});

  @override
  State<FatoDoDia> createState() => _FatoDoDiaState();
}

class _FatoDoDiaState extends State<FatoDoDia> {
  int vidas = 3;
  Pergunta? pergunta;
  late SharedPreferences prefs;
  bool respondeuHoje = false;

  @override
  void initState() {
    super.initState();
    inicializar();
  }

  Future<void> inicializar() async {
    prefs = await SharedPreferences.getInstance();

    String? dataSalva = prefs.getString('data_pergunta');
    String dataHoje = DateTime.now().toIso8601String().substring(0, 10);

    if (dataSalva == dataHoje) {
      respondeuHoje = prefs.getBool('respondido_hoje') ?? false;

      String? perguntaJson = prefs.getString('pergunta_json');
      if (perguntaJson != null) {
        setState(() {
          pergunta = Pergunta.fromJsonString(perguntaJson);
          pergunta!.respostas.shuffle();
        });
      } else {
        await obterPergunta();
      }
    } else {
      await obterPergunta();
      await prefs.setBool('respondido_hoje', false);
    }
  }

  Future<void> salvarPerguntaDia() async {
    if (pergunta == null) return;

    String dataHoje = DateTime.now().toIso8601String().substring(0, 10);
    await prefs.setString('data_pergunta', dataHoje);

    String perguntaJson = pergunta!.toJsonString();
    await prefs.setString('pergunta_json', perguntaJson);
  }

  Future<void> obterPergunta() async {
    var banco = FirebaseFirestore.instance.collection("pergunta");
    var query = await banco.count().get();
    int qtd = query.count!;
    var rnd = Random().nextInt(qtd);
    var docs = await banco.where("id", isEqualTo: rnd).get();

    setState(() {
      pergunta = Pergunta.fromSnapshot(docs.docs.first);
      pergunta!.respostas.shuffle();
      vidas = 3;
      respondeuHoje = false;
    });

    await salvarPerguntaDia();
  }

  void responder(String resposta) {
    if (pergunta == null || respondeuHoje || vidas == 0) return;

    bool correto = resposta == pergunta!.respostaCorreta;

    if (correto) {
      showDialog(
        context: context,
        builder: (_) => CaixaDialogo("Correto", "Você acertou!"),
      );
      setState(() {
        respondeuHoje = true;
      });
      prefs.setBool('respondido_hoje', true);
    } else {
      setState(() => vidas--);
      showDialog(
        context: context,
        builder: (_) => CaixaDialogo("Errado", "Você errou."),
      );
    }

    if (vidas == 0) {
      showDialog(
        context: context,
        builder: (_) =>
            CaixaDialogo("Fim de jogo", "Você perdeu todas as vidas."),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;
    final isDead = vidas == 0 || respondeuHoje;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: MeuTexto(
          texto: "Fato do Dia",
          cor: Colors.white,
          tamanhoFonte: 20,
          negrito: FontWeight.bold,
        ),
        backgroundColor: Colors.lightBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true, // ✅ Garante botão de voltar
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
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: pergunta == null
                ? const Center(child: CircularProgressIndicator())
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MeuTexto(
                  texto: "Pergunta",
                  tamanhoFonte: 20,
                  negrito: FontWeight.bold,
                  cor: Colors.blue.shade800,
                ),
                const SizedBox(height: 12),
                MeuTexto(
                  texto: pergunta!.pergunta,
                  tamanhoFonte: 16,
                  cor: Colors.black87,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    vidas,
                        (index) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        "❤️",
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Column(
                  children: pergunta!.respostas.map((resposta) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: Botoes(
                          resposta,
                          corFundo: isDead
                              ? Colors.grey
                              : Colors.lightBlue.shade600,
                          onPressed: isDead
                              ? null
                              : () => responder(resposta),
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
