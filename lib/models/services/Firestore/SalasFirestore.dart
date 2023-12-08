import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../view_model/SnackBarViewModel.dart';
import '../../Sala.dart';

class SalasFirestore {

  SnackBarViewModel mensagemSnackBar = SnackBarViewModel();
  CollectionReference<Map<String, dynamic>> db = FirebaseFirestore.instance.collection('salaConjunto');

  //CREATE
  criarSalaConjunto(String nomeConjunto, String subTitulo, String linkFoto) {
    final salaConjunto = {
      "nomeConjunto": nomeConjunto,
      "subTitulo": subTitulo,
      "linkFoto": linkFoto,
      "Salas": []
    };
    db.doc().set(salaConjunto);
  }

  criarSala(BuildContext context, String nomeConjunto, int capacidade, String nomeSala, String linkFoto) {
    final sala = Sala(
      capacidade: capacidade,
      nome: nomeSala,
      linkFoto: linkFoto,
      agendamentos: []
    );
    
    db.doc(nomeConjunto).update({
      'Salas': FieldValue.arrayUnion([sala.toMap()]),
    }).then((_) {
      mensagemSnackBar.sucesso(context, "Sala adicionada com sucesso!");
    }).catchError((error) {
      print(error);
      mensagemSnackBar.erro(context, "Erro ao adicionar a sala: $error");
    });
  }

  criarAgendamento({
    required BuildContext context,
    required String nomeConjunto,
    required String titulo,
    required String nomeSala,
    String? nota,
    required String data,
    required String timeInicial,
    required String timeFinal,
    required String nomeProfessor,
    required String idProfessor,
  }) async {
    final agendamento = {
      "idProfessor": idProfessor,
      "titulo": titulo,
      "nota": nota,
      "data": data,
      "timeInicial": timeInicial,
      "timeFinal": timeFinal,
      "professor": nomeProfessor,
    };

    try {
      final salaDoc = await db.doc(nomeConjunto).get();

      if (salaDoc.exists) {
        final salaData = salaDoc.data() as Map<String, dynamic>?;
        final salas = salaData?['Salas'] as List<dynamic>?;

        if (salas != null) {
          // Encontre a sala correta na lista de salas
          final salaIndex = salas.indexWhere((sala) => sala['nome'] == nomeSala);

          if (salaIndex != -1) {
            // Se a sala foi encontrada, adicione o agendamento à lista de agendamentos dessa sala
            if (salas[salaIndex]['agendamentos'] == null) {
              salas[salaIndex]['agendamentos'] = [agendamento];
            } else {
              salas[salaIndex]['agendamentos'].add(agendamento);
            }

            // Atualize a sala no Firestore
            await db.doc(nomeConjunto).update({'Salas': salas});

            mensagemSnackBar.sucesso(context, "Agendamento adicionado com sucesso!");
            
          } else { mensagemSnackBar.erro(context, "Sala não encontrada."); }
        } else { mensagemSnackBar.erro(context, "Lista de salas não encontrada."); }
      } else { mensagemSnackBar.erro(context, "Documento de sala não encontrado."); }
    } catch (error) { mensagemSnackBar.erro(context, "Erro ao adicionar o agendamento: $error"); }
  }

  apagarAgendamento({
    required BuildContext context,
    required String nomeConjunto,
    required String nomeSala,
    required String dataAgendamento,
    required String tituloAgendamento,
  }) {
    try {
      // Recupere o documento do conjunto de salas
      db.doc(nomeConjunto).get().then((conjuntoDoc) {
        if (conjuntoDoc.exists) {
          final conjuntoData = conjuntoDoc.data();

          final salas = conjuntoData?['Salas'] as List<dynamic>;
          final salaIndex = salas.indexWhere((sala) => sala['nome'] == nomeSala);

          // Obtenha a lista de agendamentos da sala
          final agendamentos = salas[salaIndex]['agendamentos'] as List<dynamic>;

          // Encontre o índice do agendamento com base nos critérios especificados
          final agendamentoIndex = agendamentos.indexWhere((agendamento) =>
            agendamento['data'] == dataAgendamento && agendamento['titulo'] == tituloAgendamento
          );

          // Remova o agendamento da lista de agendamentos
          agendamentos.removeAt(agendamentoIndex);

          // Atualize a sala no Firestore para refletir as alterações
          db.doc(nomeConjunto).update({'Salas': salas});

          mensagemSnackBar.sucesso(context, "Agendamento apagado com sucesso!");

        } else {
          mensagemSnackBar.erro(context, "Documento de conjunto não encontrado.");
        }
      }).catchError((error) {
        mensagemSnackBar.erro(context, "Erro ao apagar o agendamento: $error");
      });
    } catch (error) {
      mensagemSnackBar.erro(context, "Erro ao apagar o agendamento: $error");
    }
  }

  //DELETE
  deletarAgendamento(
    BuildContext context,
    String nomeConjunto,
    int capacidade,
    String titulo,
    String nomeSala,
    String? nota,
    String data,
    String timeInicial,
    String timeFinal,
    String nomeProfessor,
    String idProfessor,
  ) {
    final agendamentos = {
      "idProfessor": idProfessor,
      "titulo": titulo,
      "nota": nota,
      "data": data,
      "timeInicial": timeInicial,
      "timeFinal": timeFinal,
      "professor": nomeProfessor,
    };

    db.doc(nomeConjunto).update({
      'Salas': 
        {
          'capacidade': capacidade,
          'nome': nomeSala,
          'agendamentos': FieldValue.arrayRemove(
            [
              agendamentos
            ]
          )
        }
    });
  }

  //DELETE
  deletarSala(BuildContext context, String nomeConjunto, String nomeSala, int capacidade, List agendamentos, String linkFoto) {
    db.doc(nomeConjunto).update({
      'Salas': FieldValue.arrayRemove([
        {
          'capacidade': capacidade,
          'nome': nomeSala,
          'agendamentos': agendamentos,
          'linkFoto': linkFoto
        }
      ])
    });
  }

  deletarConjunto(BuildContext context, String idConjunto) {
    db.doc(idConjunto).delete().then(
      (doc) => mensagemSnackBar.sucesso(context, "Conjunto Deletado"),
      onError: (e) => mensagemSnackBar.erro(context, "Erro ao Excluir o Conjunto")
    );
  }

  // Defina uma função chamada atualizarSala que recebe vários parâmetros
  atualizarSala({
    required BuildContext context,
    required String nomeConjunto,
    required String novoNome,
    required int novaCapacidade,
    required String fotoLink,
    required String nomeSala,
  }) async { 

    final salaAtualizada = {
      'capacidade': novaCapacidade,
      'nome': novoNome,
      'linkFoto': fotoLink
    };

    try {
      final salaDoc = await db.doc(nomeConjunto).get();

      if (salaDoc.exists) {
        final salaData = salaDoc.data() as Map<String, dynamic>?;
        final salas = salaData?['Salas'] as List<dynamic>?;

        if (salas != null) {
          final salaIndex = salas.indexWhere((sala) => sala['nome'] == nomeSala);

          if (salaIndex != -1) { // Verifique se o índice não é -1, o que significa que a sala foi encontrada

            salaAtualizada['agendamentos'] = salas[salaIndex]['agendamentos'];
            await db.doc(nomeConjunto).update({'Salas': FieldValue.arrayUnion([salaAtualizada])});
            await db.doc(nomeConjunto).update({'Salas': FieldValue.arrayRemove([salas[salaIndex]])});
            mensagemSnackBar.sucesso(context, "Sala atualizada com sucesso!");
            
          } else { mensagemSnackBar.erro(context, "Sala não encontrada."); }
        } else { mensagemSnackBar.erro(context, "Lista de salas não encontrada."); }
      } else { mensagemSnackBar.erro(context, "Documento de sala não encontrado."); }
    } catch (error) { mensagemSnackBar.erro(context, "Erro ao atualizar a sala: $error"); }
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


  // Cria uma função para atualizar o nomeConjunto e o subTitulo
  atualizarSalaConjunto(BuildContext context, String id, String nomeConjunto, String subTitulo, String fotoLink) {
    final dadosAtualizados = {
      "nomeConjunto": nomeConjunto,
      "subTitulo": subTitulo,
      "linkFoto": fotoLink
    };
    
    var docRef = db.doc(id);
    // Atualiza os campos usando o método update()
    docRef.update(dadosAtualizados).then(
      (doc) => mensagemSnackBar.sucesso(context, "Conjunto Atualizado"),
      onError: (e) => mensagemSnackBar.erro(context, "Erro ao Atualizar o Conjunto")
    );
  }
}