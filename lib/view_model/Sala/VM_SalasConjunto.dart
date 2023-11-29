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
              },
              setState: (){}
            );
          },
          verSalas: () {
            Navigator.of(context).pushReplacementNamed('/gerenciarSalas', arguments: doc.id);
          }
        );

        print('${doc.id} => ${doc.data()}');
        
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
      linkFoto = "https://scontent-gru2-2.xx.fbcdn.net/v/t39.30808-6/299995697_176545614938341_8571280725610840430_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=5f2048&_nc_ohc=b4vfM0xvH88AX9yMQjB&_nc_ht=scontent-gru2-2.xx&oh=00_AfAusDf3tRJgUk4JDAexPrinyeW3OwBBhXpHkhmN3CwvBw&oe=6569DB8E";
    }

    //Chamar model
    if (nomeValido & subTituloValido) {
      SalasFirestore().criarSalaConjunto(nomeConjunto, subTitulo, linkFoto);
      print('deu certo');
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
      print('deu certo');
      Navigator.pop(context);
    }
  }
}