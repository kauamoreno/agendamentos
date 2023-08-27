import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../view_model/SnackBarViewModel.dart';
import './Firestore/UsuarioFirestore.dart';

class Autenticacao {

  SnackBarViewModel mensagemSnackBar = SnackBarViewModel();

  //CREATE
  criarUsuario ({
    required BuildContext context,
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
      UsuarioFirestore().criarUsuario(userId, email);

      mensagemSnackBar.sucesso(context, 'Usuário criado com sucesso');
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        mensagemSnackBar.erro(context, 'Senha muito fraca, crie uma mais forte');   
        
      } else if (e.code == 'email-already-in-use') {
        mensagemSnackBar.erro(context, 'A conta já existe para esse e-mail.');   
      }
    } catch (e) {
      mensagemSnackBar.erro(context, e.toString());
    }
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
      Navigator.of(context).pushNamed('/home', arguments: permissaoRetornada);

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
}