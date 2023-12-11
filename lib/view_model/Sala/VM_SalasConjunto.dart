import 'package:agendamentos/views/components/Cards/Cards.dart';
import 'package:agendamentos/views/components/Forms.dart';
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
          leading: Image.network(data['linkFoto']),
          title: Text(data['nomeConjunto']),
          subtitle: Text(data['subTitulo']),
          trailing: const Icon(Icons.chevron_right_sharp),
          onTap: () => Navigator.of(context).pushReplacementNamed('/salas', arguments: doc.id)
        );
        
        // Adicione a instância à lista de widgets
        cards.add(salasConjunto);
      }

    } else {
      snack.erro(context, 'Erro ao obter salas de conjunto');
    }

    return cards;
  }


  



  Future<List<Widget>> gerenciarSalasConjunto(BuildContext context) async {
    final _nomeConjuntoController = TextEditingController();
    final _subTituloConjuntoController = TextEditingController();
    final _linkController = TextEditingController();
    QuerySnapshot<Map<String, dynamic>>? salasConjuntoWidget = await sala.getSalasConjunto();
    List<Widget> cards = [];

    if (salasConjuntoWidget != null) {
      for (var doc in salasConjuntoWidget.docs) {

        // Acesse os dados de cada documento usando doc.data()
        var data = doc.data();

        GestureDetector salasConjunto = cardElemento.cardConjunto(
          context: context,
          foto: data['linkFoto'],
          nome: data['nomeConjunto'],
          subtitulo: data['subTitulo'],
          id: doc.id,
          deletarConjunto: () {
            excluirConjunto(context, doc.id);
            for (var i = 0; i < 2; i++) {
              Navigator.pop(context);
            }
            Future.delayed(Duration(milliseconds: 100), () {Navigator.pushNamed(context, '/gerenciarConjunto');});
          },
          editarConjunto: () {
            _nomeConjuntoController.text = data['nomeConjunto'];
            _subTituloConjuntoController.text = data['subTitulo'];
            _linkController.text = data['linkFoto'];
            FormsPopUp().formsConjunto(
              context: context,
              tituloController: _nomeConjuntoController,
              subtituloController: _subTituloConjuntoController,
              linkController: _linkController,
              funcaoCreate: () {
                atualizarConjunto(context, doc.id, _nomeConjuntoController.text, _subTituloConjuntoController.text, _linkController.text);
                for (var i = 0; i < 3; i++) {
                  Navigator.pop(context);
                }
                Navigator.pushNamed(context, '/gerenciarConjunto');
              },
              setState: (){}
            );
          },
          verSalas: () {
            Navigator.of(context).pushReplacementNamed('/gerenciarSalas', arguments: doc.id);
          }
        );
        
        // Adicione a instância à lista de widgets
        cards.add(salasConjunto);
      }

    } else {
      snack.erro(context, 'Erro ao obter as salas de conjunto');
    }

    return cards;
  }

  cadastrarConjunto(BuildContext context, String nomeConjunto, String subTitulo, String linkFoto) {
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

    if (linkFoto.length < 10) {
      linkFoto = "https://cdn-icons-png.flaticon.com/256/1387/1387964.png";
    }

    //Chamar model
    if (nomeValido & subTituloValido) {
      SalasFirestore().criarSalaConjunto(nomeConjunto, subTitulo, linkFoto);
      Navigator.pop(context);
    }
  }

  excluirConjunto(BuildContext context, String idConjunto) {
    SalasFirestore().deletarConjunto(context, idConjunto);
  }

  atualizarConjunto(BuildContext context, String id, String nomeConjunto, String subTitulo, String fotoLink) {
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
      SalasFirestore().atualizarSalaConjunto(context, id, nomeConjunto, subTitulo, fotoLink);
    }
  }
}