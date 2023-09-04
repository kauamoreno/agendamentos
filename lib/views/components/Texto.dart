import 'package:flutter/material.dart';
import '../constants/Cores.dart';

class ElementoTexto {

  static Widget enviarTexto(String texto, double tamanho, Color corFonte, FontWeight expessura, TextDecoration decoracao, TextAlign alinhamento, String fonte) {
    return Text('$texto', textAlign: alinhamento, style: TextStyle(fontFamily: fonte, fontSize: tamanho, color: corFonte, fontWeight: expessura, decoration: decoracao));
  }

  escreverTexto(
    {
      required String texto,
      double tamanho = 16, 
      Color corFonte = Cores.black, 
      FontWeight expessura = FontWeight.normal, 
      TextDecoration decoracao = TextDecoration.none,
      TextAlign alinhamento = TextAlign.left,
      String fonte = "Arial"
    }
  ){
    return enviarTexto(texto, tamanho, corFonte, expessura, decoracao, alinhamento, fonte);
  }
}