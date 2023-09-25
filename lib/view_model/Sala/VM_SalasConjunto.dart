import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/services/Firestore/SalasFirestore.dart';
import '../SnackBarViewModel.dart';

class VM_SalasConjunto {
  SalasFirestore sala = SalasFirestore();
  SnackBarViewModel snack = SnackBarViewModel();

  Future<List<Widget>> mostrarSalasConjunto(BuildContext context) async {

    QuerySnapshot<Map<String, dynamic>>? salasConjuntoWidget = await sala.getSalasConjunto();
    List<Widget> cards = [];

    if (salasConjuntoWidget != null) {
      for (var doc in salasConjuntoWidget.docs) {

        // Acesse os dados de cada documento usando doc.data()
        var data = doc.data();
        var salasConjunto = ListTile(
          leading: Image.network('https://www.offidocs.com/images/xtwitterdefaultpfpicon.jpg.pagespeed.ic.9q2wXBQmsW.jpg'),
          title: Text(data['nomeConjunto']),
          subtitle: Text(data['subTitulo']),
          trailing: const Icon(Icons.chevron_right_sharp),
          onTap: () => Navigator.of(context).pushReplacementNamed('/salas', arguments: doc.id)
        );

        print('${doc.id} => ${doc.data()}');
        
        // Adicione a instância à lista de widgets
        cards.add(salasConjunto);
      }

    } else {
      snack.erro(context, 'Erro ao obter salas de conjunto');
    }

    return cards;
  }
}