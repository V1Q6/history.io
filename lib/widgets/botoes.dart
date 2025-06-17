import 'package:flutter/material.dart';

class Botoes extends StatelessWidget {
  final String texto;
  final void Function()? onPressed;
  final Color corFundo;

  Botoes(this.texto, {required this.onPressed, this.corFundo = Colors.white});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        this.texto,
        style: const TextStyle(color: Colors.white), // texto branco nitido
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: corFundo,
      ),
    );
  }
}
