import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/MensagemSnackBar.dart';

class Autenticacao {

  MensagemSnackBar mensagemSnackBar = MensagemSnackBar();
  
  //CREATE
  criarUsuario ({
    required BuildContext context,
    required String email,
    required String senha
  }) async {

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      print('Usuário criado com sucesso');
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        mensagemSnackBar.showErro(context, 'Senha muito fraca, crie uma mais forte');   
        
      } else if (e.code == 'email-already-in-use') {
        mensagemSnackBar.showErro(context, 'A conta já existe para esse e-mail.');   
      }
    } catch (e) {
      mensagemSnackBar.showErro(context, e.toString());
    }
  }

  //LOGIN
  fazerLogin({
    required BuildContext context,
    required String email,
    required String senha
  }) async {

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: senha
      );
      Navigator.of(context).pushReplacementNamed('/home');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        mensagemSnackBar.showErro(context, 'Usuário não encontrado com esse email');

      } else if (e.code == 'wrong-password') {
        mensagemSnackBar.showErro(context, 'Senha incorreta');
      }
    }
  }
}