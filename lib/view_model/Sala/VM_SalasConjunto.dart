import 'package:agendamentos/views/components/Cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/services/Firestore/SalasFirestore.dart';
import '../SnackBarViewModel.dart';

class VM_SalasConjunto {
  SalasFirestore sala = SalasFirestore();
  SnackBarViewModel snack = SnackBarViewModel();
  ElementoCard cardElemento = ElementoCard();

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

  Future<List<Widget>> gerenciarSalasConjunto(BuildContext context) async {

    QuerySnapshot<Map<String, dynamic>>? salasConjuntoWidget = await sala.getSalasConjunto();
    List<Widget> cards = [];

    if (salasConjuntoWidget != null) {
      for (var doc in salasConjuntoWidget.docs) {

        // Acesse os dados de cada documento usando doc.data()
        var data = doc.data();

        Card salasConjunto = cardElemento.cardConjunto(
          context: context,
          foto: "https://www.offidocs.com/images/xtwitterdefaultpfpicon.jpg.pagespeed.ic.9q2wXBQmsW.jpg",
          nome: data['nomeConjunto'],
          subtitulo: data['subTitulo'],
          id: doc.id,
          deletarConjunto: () {
            excluirConjunto(context, doc.id);
          },
        );
        // var salasConjunto = ListTile(
        //   leading: Image.network('https://www.offidocs.com/images/xtwitterdefaultpfpicon.jpg.pagespeed.ic.9q2wXBQmsW.jpg'),
        //   title: Text(data['nomeConjunto']),
        //   subtitle: Text(data['subTitulo']),
        //   trailing: const Icon(Icons.chevron_right_sharp),
        //   onTap: () => Navigator.of(context).pushReplacementNamed('/salas', arguments: doc.id)
        // );

        print('${doc.id} => ${doc.data()}');
        
        // Adicione a instância à lista de widgets
        cards.add(salasConjunto);
      }

    } else {
      snack.erro(context, 'Erro ao obter as salas de conjunto');
    }

    return cards;
  }

  cadastrarConjunto(BuildContext context, String nomeConjunto, String subTitulo) {
    var nomeValido = false;
    if (nomeConjunto.length < 1) {
      snack.erro(context, 'Insira um nome de conjunto maior');
    } else if (nomeConjunto.length > 20) {
      snack.erro(context, 'Insira um nome de conjunto menor');
    } else {
      nomeValido = true;
    }

    var subTituloValido = false;
    if (subTitulo.length < 10) {
      snack.erro(context, 'Insira um subtitulo maior');
    } else if(subTitulo.length > 30) {
      snack.erro(context, 'Insira um subtitulo menor');
    } else {
      subTituloValido = true;
    }

    //Chamar model
    if (nomeValido & subTituloValido) {
      SalasFirestore().criarSalaConjunto(nomeConjunto, subTitulo);
      print('deu certo');
      Navigator.pop(context);
    }
  }

  excluirConjunto(BuildContext context, String idConjunto) {
    SalasFirestore().deletarConjunto(context, idConjunto);
  }

  atualizarConjunto(BuildContext context, String id, String nomeConjunto, String subTitulo) {
    var nomeValido = false;
    if (nomeConjunto.length < 1) {
      snack.erro(context, 'Insira um nome de conjunto maior');
    } else if (nomeConjunto.length > 20) {
      snack.erro(context, 'Insira um nome de conjunto menor');
    } else {
      nomeValido = true;
    }

    var subTituloValido = false;
    if (subTitulo.length < 10) {
      snack.erro(context, 'Insira um subtitulo maior');
    } else if(subTitulo.length > 30) {
      snack.erro(context, 'Insira um subtitulo menor');
    } else {
      subTituloValido = true;
    }

    //Chamar model
    if (nomeValido & subTituloValido) {
      SalasFirestore().atualizarSalaConjunto(context, id, nomeConjunto, subTitulo);
      print('deu certo');
      Navigator.pop(context);
    }
  }
}