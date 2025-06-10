import 'package:flutter/material.dart';
import 'botoes.dart';
import 'meutexto.dart';

class CaixaDialogo extends StatelessWidget {
  final String descricao;
  final String titulo;

  CaixaDialogo(this.titulo, this.descricao, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: MeuTexto(texto: titulo, cor:  Colors.black, tamanhoFonte:  20),
      content: MeuTexto(texto: descricao, cor:  Colors.black, tamanhoFonte: 12),
      actions: [
        Botoes("Ok", onPressed: () => Navigator.pop(context))
      ],
    );
  }
}
