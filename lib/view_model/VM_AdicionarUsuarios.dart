import 'package:agendamentos/models/services/Autenticacao.dart';
import 'package:agendamentos/view_model/SnackBarViewModel.dart';
import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';

class GerenciarUsuario {
  SnackBarViewModel mensagemSnackBar = SnackBarViewModel();

  //FUTURE
  cadastro(BuildContext context, String nome, String email, String senha) async {
    //Verifica Nome
    bool nomeValido = false;
    if (nome.length < 5) {
      mensagemSnackBar.erro(context, 'Insira um nome maior');
    } else {
      nomeValido = true;
    }

    //Verifica Email
    var valido = EmailValidator().validate(label: email, value: email);
    if (email.isEmpty) {
      valido = 'campo vazio';
    }
    bool mailValido = valido == null;
    if (!mailValido) {
      mensagemSnackBar.erro(context, 'Insira um email válido');
    }

    //Verifica Senha
      // Verifica se a senha contém uma letra maiúscula
    const String erroMaiusculo = r'(?=.*[A-Z])';
      // Verifica se a senha contém uma letra minúscula
    const String erroMinusculo = r'(?=.*[a-z])';
      // Verifica se a senha contém um número
    const String erroNumero = r'(?=.*\d)';
      // Verifica se a senha tem pelo menos 8 caracteres
    const String erroTamanho = r'.{8,}';

    bool senhaValida = false;
    if (!RegExp(erroTamanho).hasMatch(senha)) {
      mensagemSnackBar.erro(context, 'A senha deve ter pelo menos 8 caracteres');
    } else if (!RegExp(erroNumero).hasMatch(senha)) {
      mensagemSnackBar.erro(context, 'A senha deve conter pelo menos um número');
    } else if (!RegExp(erroMinusculo).hasMatch(senha)) {
      mensagemSnackBar.erro(context, 'A senha deve conter alguma letra minúscula');
    } else if (!RegExp(erroMaiusculo).hasMatch(senha)) {
      mensagemSnackBar.erro(context, 'A senha deve conter alguma letra maiúscula');
    } else {
      senhaValida = true;
    }

    //Chamar model
    if (nomeValido & mailValido & senhaValida) {
      if (await Autenticacao().criarUsuario(context: context, nome: nome, email: email, senha: senha)) {
        print('deu certo');
      }else {
        print('não deu');
      }
    }
  }
}
