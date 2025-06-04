import 'package:flutter/material.dart';
class MeuTexto extends StatelessWidget {
  String texto;
  double tamanhoFonte;
  Color cor;
  FontWeight negrito;
  MeuTexto({
    this.texto = "",
    this.cor = Colors.black,
    this.tamanhoFonte = 12,
    this.negrito = FontWeight.normal
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: TextStyle(
        color: cor,
        fontSize: tamanhoFonte,

      ),
    );
  }
}
