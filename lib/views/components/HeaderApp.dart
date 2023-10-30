

import 'package:flutter/material.dart';

HeaderApp (BuildContext context, IconData icone) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 10),
    child: Container(
      width: 80, // Largura do botão
      height: 80, // Altura do botão
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red, // Cor do círculo
      ),
      child: Center(
        child: Icon(
          icone,
          size: 55,
          color: Colors.white, // Cor do ícone
        )
      )
    )
  );
}