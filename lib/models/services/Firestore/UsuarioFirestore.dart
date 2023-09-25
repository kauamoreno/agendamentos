import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../view_model/SnackBarViewModel.dart';

class UsuarioFirestore {

  SnackBarViewModel mensagemSnackBar = SnackBarViewModel();
  CollectionReference<Map<String, dynamic>> db = FirebaseFirestore.instance.collection('usuarios');

  //CREATE
  criarUsuario(String id, String nome, String email) {
    final usuario = {
      "nome": nome,
      "email": email,
      "isAdm": false,
    };

    db.doc(id).set(usuario);
  }

  //DELETE
  deletarUsuario(BuildContext context, String id) {
    db.doc(id).delete().then(
      (doc) => mensagemSnackBar.sucesso(context, "Documento deletado"),
      onError: (e) => mensagemSnackBar.erro(context, "Erro em apagar o usuário"),
    );
  }

  //READ USER
  Future<Map<String, dynamic>?> getUsuario(String id) async {
    final docRef = db.doc(id);

    try {
      DocumentSnapshot doc = await docRef.get();
      Map<String, dynamic> usuario = doc.data() as Map<String, dynamic>;
      return usuario;

    } catch (e) {
      print("Erro: $e");
      return null;
    }
  }

  //READ USER PERMISSAO
  Future<bool?> getPermissao(String id) async {
    Map<String, dynamic>? usuarioMap = await getUsuario(id);

    if (usuarioMap != null && usuarioMap.containsKey('isAdm')) {
      bool permissao = usuarioMap['isAdm'];
      return permissao;
      
    } else {
      return null; 
    }
  }
}