import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String nome = "";
  bool tema = true;
  int fatosDoDiaSeguido = 0;
  int recordeIlimitado = 0;

  Usuario.fromSnapshot(DocumentSnapshot snapshot) {
    nome = snapshot['nome'] ?? "";
    tema = snapshot['tema'] ?? true;
    var estatisticas = snapshot['estatisticas'] ?? {};
    fatosDoDiaSeguido = estatisticas['fatosDoDiaSeguido'] ?? 0;
    recordeIlimitado = estatisticas['recordeIlimitado'] ?? 0;
  }
}