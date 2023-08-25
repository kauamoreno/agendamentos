import 'package:flutter/material.dart';

class SalasCard extends StatelessWidget {
  final String imgUrl;
  final String titulo;
  final String subTitulo;

  SalasCard({
    required this.imgUrl,
    required this.titulo,
    required this.subTitulo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        imgUrl,
        width: 300,
        height: 500,
        fit: BoxFit.cover
      ),
      title: Text(titulo),
      subtitle: Text(subTitulo),
      onTap: () {
        print('clicado');
      },
    );
  }
}
