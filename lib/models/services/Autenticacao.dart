import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../view_model/SnackBarViewModel.dart';
import './Firestore/UsuarioFirestore.dart';

class Autenticacao {

  SnackBarViewModel mensagemSnackBar = SnackBarViewModel();

  //CREATE
  Future<bool> criarUsuario ({
    required BuildContext context,
    required String nome,
    required String email,
    required String senha
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      String userId = '';
      User? user = userCredential.user;
      if (user != null) {
        userId = user.uid;
      }
      UsuarioFirestore().criarUsuario(userId, nome, email);

      mensagemSnackBar.sucesso(context, 'Usuário criado com sucesso');
      return true;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        mensagemSnackBar.erro(context, 'Senha muito fraca, crie uma mais forte');   
        return false;

      } else if (e.code == 'email-already-in-use') {
        mensagemSnackBar.erro(context, 'A conta já existe para esse e-mail.');
        return false;
      }
    } catch (e) {
      mensagemSnackBar.erro(context, e.toString());
      return false;
    }
    return false;
  }

  //LOGIN
  fazerLogin({
    required BuildContext context,
    required String email,
    required String senha
  }) async {

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: senha
      );
      
      String userId = '';
      User? user = userCredential.user;
      if (user != null) {
        userId = user.uid;
      }

      bool? permissaoRetornada = await UsuarioFirestore().getPermissao(userId);
      switch (permissaoRetornada) {
        case true:
          Navigator.of(context).pushReplacementNamed('/admHome');      
          break;
        case false:
          Navigator.of(context).pushReplacementNamed('/userHome');
          break;
        default:
          Navigator.of(context).pushReplacementNamed('/erro', arguments: 'Desculpe, mas parece que houve um problema ao tentar exibir a página inicial. Por favor, tente novamente');
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        mensagemSnackBar.erro(context, 'Usuário não encontrado com esse email');

      } else if (e.code == 'wrong-password') {
        mensagemSnackBar.erro(context, 'Senha incorreta');

      } else {
        mensagemSnackBar.erro(context, e.toString());
      }
    }
  }

  Future<String?> getIdNomeProfessorLogado(bool isId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;
        Map<String, dynamic>? usuarioMap = await UsuarioFirestore().getUsuario(userId);

        if (usuarioMap != null && usuarioMap.containsKey('nome')) {
          String nome = usuarioMap['nome'];
          if(isId) { return userId; } else { return nome; }
        }
      }
      return null;
      
    } catch (e) {
      print("Erro ao obter o nome do professor logado: $e");
      return null;
    }
  }

}