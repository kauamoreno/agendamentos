import 'package:flutter/material.dart';
import '../constants/Cores.dart';

class MensagemSnackBar {

  static void _show(BuildContext context, String mensagem, IconData icone, Color cor) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            icone,
            color: Cores.white
          ),
          const SizedBox(width: 10),
          Text( 
            mensagem, 
            style: const TextStyle(
              color: Cores.white
            )
          )
        ],
      ),
      backgroundColor: cor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showErro(BuildContext context, String erroMensagem){
    _show(context, erroMensagem, Icons.error_outline, Cores.redDanger);
  }

  showSucesso(BuildContext context, String sucessoMensagem){
    _show(context, sucessoMensagem, Icons.check_circle_outline, Cores.azul);
  }
  
}
