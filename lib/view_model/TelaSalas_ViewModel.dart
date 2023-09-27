import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/services/Firestore/SalasFirestore.dart';
import '../views/components/SalasCard.dart';
import 'SnackBarViewModel.dart';

class TelaSalas_ViewModel {

  SalasFirestore sala = SalasFirestore();
  SnackBarViewModel snack = SnackBarViewModel();

  Future<List<Widget>> mostrarSalasConjunto(BuildContext context) async {

    QuerySnapshot<Map<String, dynamic>>? salasConjuntoWidget = await sala.getSalasConjunto();
    SalasCard salasCard = SalasCard();
    List<Widget> cards = [];

    if (salasConjuntoWidget != null) {
      for (var doc in salasConjuntoWidget.docs) {

        // Acesse os dados de cada documento usando doc.data()
        var data = doc.data();
        var salasConjunto = salasCard.salaConjunto(
          context: context,
          imgUrl: 'https://www.offidocs.com/images/xtwitterdefaultpfpicon.jpg.pagespeed.ic.9q2wXBQmsW.jpg',
          subTitulo: data['subTitulo'],
          titulo: data['nome'], 
          nomeConjunto: '', 
          nomeSala: data['id'],
        );

        // Adicione a instância à lista de widgets
        cards.add(salasConjunto);
      }
    } else {
      snack.erro(context, 'Erro ao obter salas de conjunto');
    }

    return cards;
  }
}
