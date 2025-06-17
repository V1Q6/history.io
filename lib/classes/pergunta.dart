import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Pergunta {
  int id = 0;
  String pergunta = "";
  List<String> respostas = ["", "", "", "", ""];
  String respostaCorreta = "";

  Pergunta({int? id, String? pergunta, List<String>? respostas, String? respostaCorreta}) {
    if (id != null) this.id = id;
    if (pergunta != null) this.pergunta = pergunta;
    if (respostas != null) this.respostas = respostas;
    if (respostaCorreta != null) this.respostaCorreta = respostaCorreta;
  }

  Pergunta.fromSnapshot(DocumentSnapshot snapshot){
    id = snapshot['id'];
    pergunta = snapshot['pergunta'];
    respostas = snapshot['respostas'].cast<String>();
    respostaCorreta = snapshot['respostaCorreta'];
  }

  // Construtor para criar a partir de JSON String
  factory Pergunta.fromJsonString(String jsonString) {
    final data = jsonDecode(jsonString);
    return Pergunta(
      id: data['id'],
      pergunta: data['pergunta'],
      respostas: List<String>.from(data['respostas']),
      respostaCorreta: data['respostaCorreta'],
    );
  }

  // Método para converter para JSON String
  String toJsonString() {
    final map = {
      'id': id,
      'pergunta': pergunta,
      'respostas': respostas,
      'respostaCorreta': respostaCorreta,
    };
    return jsonEncode(map);
  }
}
