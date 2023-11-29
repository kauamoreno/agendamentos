// ignore_for_file: use_build_context_synchronously

import 'package:agendamentos/models/services/Autenticacao.dart';
import 'package:agendamentos/models/services/Firestore/UsuarioFirestore.dart';
import 'package:agendamentos/view_model/SnackBarViewModel.dart';
import 'package:agendamentos/views/components/Cards/Cards.dart';
import 'package:agendamentos/views/components/Forms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';

class GerenciarUsuario {
  SnackBarViewModel mensagemSnackBar = SnackBarViewModel();
  ElementoCard cardElemento = ElementoCard();

  //MÉTODO CREATE USUARIO
  Future<bool> cadastro(BuildContext context, String nome, String email, String senha) async {
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
        Navigator.pop(context);
        return true;
      }else {
        print('não deu');
        return false;
      }
    } else {
      return false;
    }
  }

  UsuarioFirestore user = UsuarioFirestore();

  //MÉTODO READ USUARIO
  Future<List<Widget>> mostrarUsuarios(BuildContext context) async {
    final _nomeProf = TextEditingController();

    QuerySnapshot<Map<String, dynamic>>? usuariosWidget = await user.getTodosUsuarios();
    print(usuariosWidget);
    List<Widget> cards = [];

    if (usuariosWidget != null) {
      for (var doc in usuariosWidget.docs) {
        // Acesse os dados de cada documento usando doc.data()
        var data = doc.data();

        if (!data['isAdm']) {
          var usuarios = cardElemento.cardProfessor(
            context: context, 
            nome: data['nome'], 
            email: data['email'], 
            id: doc.id,
            verAgendas: () {
              Navigator.of(context).pushReplacementNamed('/minhasAgendas', arguments: doc.id);
            },
            editarProf: () {
              _nomeProf.text = data['nome'];
              FormsPopUp().formsProfessor(
                context: context, 
                nomeProfController: _nomeProf, 
                emailProfController: TextEditingController(), 
                senhaProfController: TextEditingController(), 
                funcaoCreate: () {
                  // CRIAR FUNÇÃO PARA EDITAR
                }, 
                setState: (){},
                editar: true
              );
            },
            excluirProf: () {}
          );

          print('${doc.id} => ${doc.data()}');

          // Adicione a instância à lista de widgets
          cards.add(usuarios);
        }
      }

    } else {
      mensagemSnackBar.erro(context, 'Erro ao obter os Usuarios');
    }
    return cards;
  }
}
