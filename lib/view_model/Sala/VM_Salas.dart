import 'package:agendamentos/models/services/Firestore/SalasFirestore.dart';
import 'package:agendamentos/view_model/SnackBarViewModel.dart';
import 'package:agendamentos/views/components/Cards/Cards.dart';
import 'package:agendamentos/views/components/Forms.dart';
import 'package:agendamentos/views/components/Cards/SalasCard.dart';
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
  ElementoCard elementoCard = ElementoCard();

  Future<void> criarSala(BuildContext context, String capacidadeString, String nomeSala, String linkFoto) async {
    print(nomeConjunto);

    if(nomeSala.isEmpty || capacidadeString.isEmpty){
      return snack.erro(context, 'Dados insuficientes, preencher todos os campos');
    }

    int? capacidade;
    capacidade = int.tryParse(capacidadeString);

    if (capacidade == null || capacidade < 1) {
      print('está com número errado');
      return snack.erro(context, 'Quantidade inválida');
    } else {
      print('está com numero certo');
    }

    if (linkFoto.length < 10) {
      return snack.erro(context, "Este link parece ser pequeno demais");
    }

    await firestore.criarSala(
      context, 
      nomeConjunto, 
      capacidade, 
      nomeSala,
      linkFoto
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

          var salaWidget = salaCards.salaConjunto(
            context: context,
            imgUrl: 'https://www.offidocs.com/images/xtwitterdefaultpfpicon.jpg.pagespeed.ic.9q2wXBQmsW.jpg',
            subTitulo: "Acrescentar subtitulo", //salaData['subTitulo']
            titulo: salaData['nome'], 
            nomeConjunto: nomeConjunto, 
            nomeSala: salaData['nome'],
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

  Future<List<Widget>> mostraGerenciaSalas(BuildContext context) async {
    // Primeiro, obtenha o documento do conjunto específico
    DocumentSnapshot<Map<String, dynamic>> conjuntoDoc = await firestore.db.doc(nomeConjunto).get();
    final _nomeSalaController = TextEditingController();
    final _quantidadeController = TextEditingController();
    final _linkController = TextEditingController();

    List<Widget> cards = [];

    if (conjuntoDoc.exists) {
      var conjuntoData = conjuntoDoc.data();
      var salas = conjuntoData?['Salas'];

      if (salas != null) {
        for (var salaData in salas) {
          // var salaIndice = salas.indexOf(salas.firstWhere((s) => s['nome'] == salaData['nome'], orElse: () => null));

          var salaWidget = elementoCard.cardSala(
            context: context,
            foto: salaData['linkFoto'],
            nome: salaData['nome'],
            quantidade: salaData['capacidade'],
            id: nomeConjunto,
            deletarSala: () {
              SalasFirestore().deletarSala(
                context, 
                nomeConjunto, 
                salaData['nome'], 
                salaData['capacidade'], 
                salaData['agendamentos']
              );
            },
            editarSala: () {
              _nomeSalaController.text = salaData['nome'];
              _quantidadeController.text = "${salaData['capacidade']}";
              FormsPopUp().formsSala(
                context: context, 
                nomeSalaController: _nomeSalaController, 
                quantidadeController: _quantidadeController,
                linkController: _linkController,
                uidConjunto: nomeConjunto, 
                funcaoCreate: () {
                  editarSala(
                    context, 
                    _quantidadeController.text, 
                    _nomeSalaController.text,
                    salaData['nome']
                  );
                }, 
                setState: (){}
              );
            }
          );
          cards.add(salaWidget);
          print(salaData);
        }
      } else {
        snack.erro(context, 'Não há salas neste conjunto');
      }
    } else {
      snack.erro(context, 'Conjunto não encontrado');
    }

    return cards;
  }

  Future<void> editarSala(BuildContext context, String capacidadeString, String nomeSala, String nomeAntigoSala) async {

    if(nomeSala.isEmpty || capacidadeString.isEmpty){
      return snack.erro(context, 'Dados insuficientes, preencher todos os campos');
    }

    int? capacidade;
    capacidade = int.tryParse(capacidadeString);

    if (capacidade == null || capacidade < 1) {
      print('está com número errado');
      return snack.erro(context, 'Quantidade inválida');
    } else {
      print('está com numero certo');
    }

    await firestore.atualizarSala(
      context: context,
      nomeConjunto: nomeConjunto, 
      novoNome: nomeSala, 
      novaCapacidade: capacidade, 
      nomeSala: nomeAntigoSala);
  }
}