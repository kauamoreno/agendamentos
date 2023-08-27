import 'package:flutter/material.dart';
import '../views/components/MensagemSnackBar.dart';

class SnackBarViewModel {

  erro(BuildContext context, String erroMensagem){
    MensagemSnackBar mensagemErro = MensagemSnackBar();
    mensagemErro.showErro(context, erroMensagem);
  }

  sucesso(BuildContext context, String erroMensagem){
    MensagemSnackBar mensagemErro = MensagemSnackBar();
    mensagemErro.showSucesso(context, erroMensagem);
  }
}