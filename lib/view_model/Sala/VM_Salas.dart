import 'package:agendamentos/models/services/Firestore/SalasFirestore.dart';
import 'package:agendamentos/view_model/SnackBarViewModel.dart';
import 'package:agendamentos/views/components/SalasCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VM_Salas {

  final String nomeConjunto;
  VM_Salas({
    required this.nomeConjunto
  });

  SalasFirestore firestore = SalasFirestore();
  SnackBarViewModel snack = SnackBarViewModel();
  SalasCard salaCards = SalasCard();

  Future<void> criarSala(BuildContext context, int capacidade, String nomeSala) async {
    if(nomeSala.isEmpty){
      return snack.erro(context, 'Dados insulficientes, preencher todos os campos');
    }

    await firestore.criarSala(
      context, 
      nomeConjunto, 
      capacidade, 
      nomeSala
    );
  }

  Future<List<Widget>> mostrarSalas(BuildContext context) async {

    // Primeiro, obtenha o documento do conjunto específico
    DocumentSnapshot<Map<String, dynamic>> conjuntoDoc = await firestore.db.doc(nomeConjunto).get();

    List<Widget> cards = [];

    if (conjuntoDoc.exists) {
      var conjuntoData = conjuntoDoc.data();
      var salas = conjuntoData?['Salas'];

      if (salas != null) {
        for (var salaData in salas) {
          var nomeSala = salaData['nome'];
          var capacidadeSala = salaData['capacidade'];

          var salaWidget = SalasCard.SalasConjuntoComponent(
            context, 
            nomeSala,
            capacidadeSala.toString(), 
            'https://www.offidocs.com/images/xtwitterdefaultpfpicon.jpg.pagespeed.ic.9q2wXBQmsW.jpg'
          );
          cards.add(salaWidget);
        }
      } else {
        snack.erro(context, 'Não há salas neste conjunto');
      }
    } else {
      snack.erro(context, 'Conjunto não encontrado');
    }

    return cards;
  }

}