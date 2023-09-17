import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../view_model/SnackBarViewModel.dart';
import '../../Sala.dart';

class SalasFirestore {

  SnackBarViewModel mensagemSnackBar = SnackBarViewModel();
  CollectionReference<Map<String, dynamic>> db = FirebaseFirestore.instance.collection('salaConjunto');

  //CREATE
  criarSalaConjunto(String nomeConjunto) {
    final salaConjunto = {
      "nome": nomeConjunto,
      "salas": []
    };
    db.doc(nomeConjunto).set(salaConjunto);
  }

  criarSala(BuildContext context, String nomeConjunto, int capacidade, String nomeSala) {
    final sala = Sala(
      capacidade: capacidade, 
      nomeSala: nomeSala, 
      agendamentos: []
    );
    
    db.doc(nomeConjunto).update({
      'salas': FieldValue.arrayUnion([sala]),
    }).then((_) {
      mensagemSnackBar.sucesso(context, "Sala adicionada com sucesso!");
    }).catchError((error) {
      mensagemSnackBar.erro(context, "Erro ao adicionar a sala: $error");
    });
  }

  criarAgendamento({
    required BuildContext context,
    required String nomeConjunto,
    required String nomeSala,
    required String titulo,
    String ?nota,
    required String data,
    required String timeInicial,
    required String timeFinal,
    required String lembrete
  }) {
    final agendamento = {
      "titulo": titulo,
      "nota": nota,
      "data": data,
      "timeInicial": timeInicial,
      "timeFinal": timeFinal,
      "lembrete": lembrete,
    };

    // Atualize o array "agendamentos" dentro do documento da sala correspondente
    db.doc(nomeConjunto).update({
      'salas': FieldValue.arrayUnion([
        {
          'nomeSala': nomeSala,
          'agendamentos': [agendamento],
        },
      ]),
    }).then((_) {
      mensagemSnackBar.sucesso(context, "Agendamento adicionado com sucesso!");
    }).catchError((error) {
      mensagemSnackBar.erro(context, "Erro ao adicionar o agendamento: $error");
    });
  }

  //DELETE
  deletarSala(BuildContext context, String nomeConjunto, String idSala) {
    DocumentReference salaConjuntoDocRef = db.doc(nomeConjunto);
    CollectionReference salasCollection = salaConjuntoDocRef.collection('salas');
    
    salasCollection.doc(idSala).delete().then(
      (doc) => mensagemSnackBar.sucesso(context, "Documento deletado"),
      onError: (e) => mensagemSnackBar.erro(context, "Erro em apagar o usuário"),
    );
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