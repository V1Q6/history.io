import 'package:cloud_firestore/cloud_firestore.dart';

class Pergunta {
  int id = 0;
  String pergunta = "";
  List<String> respostas = ["", "", "", "", ""];
  String respostaCorreta = "";

  Pergunta({id, pergunta, respostas, respostaCorreta});

  Pergunta.fromSnapshot(DocumentSnapshot snapshot){
    id = snapshot['id'];
    pergunta = snapshot['pergunta'];
    respostas = snapshot['respostas'].cast<String>();
    respostaCorreta = snapshot['respostaCorreta'];
  }

}