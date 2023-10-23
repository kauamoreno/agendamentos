import 'package:agendamentos/models/services/Autenticacao.dart';
import 'package:agendamentos/models/services/Firestore/SalasFirestore.dart';
import 'package:agendamentos/views/components/Cards/CardAgendamento.dart';
import 'package:agendamentos/views/components/Cards/Cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VM_MinhasAgendas {
  SalasFirestore firestore = SalasFirestore();
  Autenticacao auth = Autenticacao();
  ElementoCard cardElemento = ElementoCard();
  CardAgendamento cardAgendamento = CardAgendamento();

  Future<List<Widget>> minhasAgendas(BuildContext context) async {
    String idProfessor = await auth.getIdNomeProfessorLogado(true) as String;
    List<Widget> agendamentosWidgets = [];

    try {
      QuerySnapshot<Map<String, dynamic>>? salasConjunto = await firestore.getSalasConjunto();
      DateTime dataAtual = DateTime.now();
      dataAtual = DateTime(dataAtual.year, dataAtual.month, dataAtual.day);


      for (QueryDocumentSnapshot salaConjuntoDoc in salasConjunto!.docs) {
        List<dynamic> salas = salaConjuntoDoc['Salas'] ?? [];

        for (dynamic sala in salas) {
          List<dynamic> agendamentos = sala['agendamentos'] ?? [];

          for (dynamic agendamento in agendamentos) {
            String idProfessorAgenda = agendamento['idProfessor'];

            String dataAgendamentoString = agendamento['data'];
            DateTime dataAgendamentoDateTime = DateFormat("dd/MM/yyyy").parse(dataAgendamentoString);

            if (idProfessorAgenda == idProfessor && dataAgendamentoDateTime.isAtSameMomentAs(dataAtual) || dataAgendamentoDateTime.isAfter(dataAtual)) {
              String titulo = agendamento['titulo'] ?? 'Sem título';
              String data = agendamento['data'] ?? 'Sem data';
              String horarioInicio = agendamento['timeInicial'] ?? 'Sem horário de início';
              String horarioFim = agendamento['timeFinal'] ?? 'Sem horário de término';
              String nota = agendamento['nota'] ?? '';
              String nomeSala = agendamento['nomeSala'] ?? 'Sem nome de sala';
              String professor = agendamento['professor'] ?? 'Sem nome de professor';

              // Crie o ListTile com os dados extraídos
              Widget agendamentoTile = cardAgendamento.getCard(
                context,
                horarioInicio,
                horarioFim,
                nomeSala,
                professor,
                nota,
                titulo,
                data
              );

              // // Adicione o ListTile à lista
              agendamentosWidgets.add(agendamentoTile);
            }
          }
        }
      }

      if (agendamentosWidgets.length.isEqual(0)) {
        agendamentosWidgets.add(const Text('Nenhuma salas agendada'));
      }
    } catch (error) {
      print('Erro ao obter agendamentos: $error');
    }

    return agendamentosWidgets;
  }
}
