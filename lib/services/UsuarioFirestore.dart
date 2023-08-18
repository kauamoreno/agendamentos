import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../components/MensagemSnackBar.dart';

class UsuarioFirestore {

  MensagemSnackBar mensagemSnackBar = MensagemSnackBar();
  CollectionReference<Map<String, dynamic>> db = FirebaseFirestore.instance.collection('usuarios');

  //CREATE
  criarUsuario(String id, String email) {
    final usuario = {
      "nome": "Teste", 
      "email": email, 
      "isAdm": false
    };

    db.doc(id).set(usuario);
  }

  //READ
  getUsuario(String id) {
    final docRef = db.doc(id);

    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        print(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  //DELETE
  deletarUsuario(BuildContext context, String id) {
    db.doc(id).delete().then(
      (doc) => print("Document deleted"),
      onError: (e) => mensagemSnackBar.showErro(context, "Erro em apagar o usuário"),
    );
  }

  atualizarUsuario(String id) {}
}
