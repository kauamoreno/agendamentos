import 'package:flutter/material.dart';
//RESTO DO CODIGO NO GPT

class MyCard extends StatelessWidget {
  final VoidCallback onTap;
  final String notaUsuario;
  final String tempoInicial;
  final String tempoFinal;

  MyCard({required this.onTap, required this.notaUsuario, required this.tempoInicial, required this.tempoFinal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        child: Container(
          width: 400.0,
          height: 150.0,
          child: Center(
            child: Text(
              notaUsuario,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ),
    );
  }
}
