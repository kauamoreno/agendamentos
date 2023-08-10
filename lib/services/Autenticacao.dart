import 'package:firebase_auth/firebase_auth.dart';

class Autenticacao {

  //CREATE
  criarUsuario ({
    required String email,
    required String senha
  }) async {

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Senha muito fraca, crie uma mais forte');
        
      } else if (e.code == 'email-already-in-use') {
        print('A conta já existe para esse e-mail.');
      }
    } catch (e) {
      print(e);
    }
  }

  //LOGIN
  fazerLogin({
    required String email,
    required String senha
  }) async {

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: senha
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Usuário não encontrado com esse email');
      } else if (e.code == 'wrong-password') {
        print('Senha incorreta');
      }
    }
  }
}
