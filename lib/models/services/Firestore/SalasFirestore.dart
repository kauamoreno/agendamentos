import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../view_model/SnackBarViewModel.dart';

class SalasFirestore {

  SnackBarViewModel mensagemSnackBar = SnackBarViewModel();
  CollectionReference<Map<String, dynamic>> db = FirebaseFirestore.instance.collection('salaConjunto');

  //CREATE
  criarSalaConjunto(String nome) {
    final salaConjunto = {
      "nome": "Mecânica",
      "salas": [
        {"nome": "Sala1", "subTitulo": "test", "capacidade": 32, "isLivre": true},
        {"nome": "Sala2", "subTitulo": "test", "capacidade": 16, "isLivre": false},
      ]
    };

    db.doc().set(salaConjunto);
  }

  //DELETE
  deletarSala(BuildContext context, String idConjunto, String idSala) {
    DocumentReference salaConjuntoDocRef = db.doc(idConjunto);
    CollectionReference salasCollection = salaConjuntoDocRef.collection('salas');
    
    salasCollection.doc(idSala).delete().then(
      (doc) => mensagemSnackBar.sucesso(context, "Documento deletado"),
      onError: (e) => mensagemSnackBar.erro(context, "Erro em apagar o usuário"),
    );
  }

  //READ SALACONJUNTO ESPECIFICA
  Future<Map<String, dynamic>?> getSalaConjuntoUnico(String idConjunto) async {
    final docRef = db.doc(idConjunto);

    try {
      DocumentSnapshot doc = await docRef.get();
      Map<String, dynamic> salaConjunto = doc.data() as Map<String, dynamic>;
      return salaConjunto;

    } catch (e) {
      print("Erro: $e");
      return null;
    }
  }

  //READ SALA ISLIVRE
  Future<bool?> getSalaIsLivre(String idConjunto, String idSala) async {

    Map<String, dynamic>? salaConjuntoMap = await getSalaConjuntoUnico(idConjunto);

    if (salaConjuntoMap != null && salaConjuntoMap.containsKey('salas')) {
      List<dynamic> salas = salaConjuntoMap['salas'];

      for (dynamic sala in salas) {
        if (sala['id'] == idSala) {
          return sala['livre'] as bool;
        }
      }
    }

    return null;
  }

  //READ TODAS SALACONJUNTO 
  Future<QuerySnapshot<Map<String, dynamic>>?> getSalasConjunto() async {
    try {
      QuerySnapshot<Map<String, dynamic>> doc = await db.get();
      return doc;
    } catch (e) {
      print("Erro: $e");
      return null;
    }
  }

}