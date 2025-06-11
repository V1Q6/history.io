import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../classes/pergunta.dart';
import '../widgets/caixaDialogo.dart';
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

  void responder(String resposta) {
    bool correto = resposta == pergunta.respostaCorreta;

    if (correto) {
      qtdAcertos++;
      showDialog(
        context: context,
        builder: (_) => CaixaDialogo("Correto", "Você acertou!"),
      );
      obterPergunta();
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
            CaixaDialogo("Fim de jogo", "Você acertou $qtdAcertos perguntas!"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDead = vidas == 0;
    final larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Text(
          "Ilimitado",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue.shade700,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Início"),
                onTap: () => Navigator.popUntil(context, ModalRoute.withName('/')),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text("Fato do Dia"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/fatoDoDia');
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.brightness_6),
                title: Text("Modo Escuro"),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: larguraTela < 500 ? double.infinity : 500,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                )
              ],
            ),
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                // Cabeçalho da pergunta
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pergunta $qtdPergunta",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      pergunta.pergunta,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // Vidas
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    vidas,
                        (i) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Text("❤️", style: TextStyle(fontSize: 24)),
                    ),
                  ),
                ),
                SizedBox(height: 24),

                // Respostas
                Column(
                  children: pergunta.respostas.map((resposta) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            backgroundColor:
                            isDead ? Colors.grey : Colors.lightBlue.shade600,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: isDead ? null : () => responder(resposta),
                          child: Text(
                            resposta,
                            style: TextStyle(fontSize: 16),
                          ),
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
