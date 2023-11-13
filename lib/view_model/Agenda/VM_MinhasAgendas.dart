import 'package:agendamentos/models/services/Autenticacao.dart';
import 'package:agendamentos/models/services/Firestore/SalasFirestore.dart';
import 'package:agendamentos/views/components/Cards/CardAgendamento.dart';
import 'package:agendamentos/views/components/Cards/Cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VM_MinhasAgendas {
  SalasFirestore firestore = SalasFirestore();
  Autenticacao auth = Autenticacao();
  ElementoCard cardElemento = ElementoCard();
  CardAgendamento cardAgendamento = CardAgendamento();
  late String nomeConjunto;

  Future<List<Widget>> minhasAgendas({required BuildContext context, String idProfessor = ''}) async {
    if (idProfessor == '') {
      idProfessor = await auth.getIdNomeProfessorLogado(true) as String;
    }
    List<Widget> agendamentosWidgets = [];
    String? dataAtualString;

    try {
      QuerySnapshot<Map<String, dynamic>>? salasConjunto = await firestore.getSalasConjunto();
      DateTime dataAtual = DateTime.now();
      dataAtual = DateTime(dataAtual.year, dataAtual.month, dataAtual.day);

      List<dynamic> agendamentos = [];

      for (QueryDocumentSnapshot salaConjuntoDoc in salasConjunto!.docs) {
        nomeConjunto = salaConjuntoDoc['nomeConjunto'] ?? [];
        String idConjunto = salaConjuntoDoc.id;
        List<dynamic> salas = salaConjuntoDoc['Salas'] ?? [];

        for (dynamic sala in salas) {
          List<dynamic> salaAgendamentos = sala['agendamentos'] ?? [];
          String nomeSala = sala['nome'];

          for (dynamic agendamento in salaAgendamentos) {
            String idProfessorAgenda = agendamento['idProfessor'];

            String dataAgendamentoString = agendamento['data'];
            DateTime dataAgendamentoDateTime = DateFormat("dd/MM/yyyy").parse(dataAgendamentoString);

            agendamento['idConjunto'] = idConjunto;
            agendamento['nomeSala'] = nomeSala;

            if (idProfessorAgenda == idProfessor && (dataAgendamentoDateTime.isAtSameMomentAs(dataAtual) || dataAgendamentoDateTime.isAfter(dataAtual))) {
              agendamentos.add(agendamento);
            }
          }
        }
      }

      // Ordenando os agendamentos por data
      agendamentos.sort((a, b) {
        String dataA = a['data'] ?? '';
        String dataB = b['data'] ?? '';
        return dataA.compareTo(dataB);
      });

      for (var agendamento in agendamentos) {
        String dataAgendamentoString = agendamento['data'];
        DateTime dataAgendamentoDateTime = DateFormat("dd/MM/yyyy").parse(dataAgendamentoString);
        String dataAgendamentoText = DateFormat("dd/MM/yyyy").format(dataAgendamentoDateTime);

        // Verifique se a data mudou e adicione o texto da data
        if (dataAtualString != dataAgendamentoText) {
          dataAtualString = dataAgendamentoText;
          agendamentosWidgets.add(
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 7),
              child: Text(
                'Data: $dataAgendamentoText',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600
                )
              ),
            )
          );
        }

        // Crie o widget do agendamento
        agendamentosWidgets.add(buildAgendamentoWidget(agendamento, context));
      }

      if (agendamentosWidgets.isEmpty) {
        agendamentosWidgets.add(const Text('Nenhum agendamento disponível'));
      }
    } catch (error) {
      print('Erro ao obter agendamentos: $error');
    }

    return agendamentosWidgets;
  }

  Widget buildAgendamentoWidget(dynamic agendamento, BuildContext context) {
    // Extrair os dados do agendamento
    String titulo = agendamento['titulo'] ?? 'Sem título';
    String data = agendamento['data'] ?? 'Sem data';
    String horarioInicio = agendamento['timeInicial'] ?? 'Sem horário de início';
    String horarioFim = agendamento['timeFinal'] ?? 'Sem horário de término';
    String nota = agendamento['nota'] ?? '';
    String nomeSala = agendamento['nomeSala'] ?? 'Sem nome de sala';
    String professor = agendamento['professor'] ?? 'Sem nome de professor';
    String idConjunto = agendamento['idConjunto'] ?? 'Sem Id';

    // Crie o ListTile com os dados extraídos
    return cardAgendamento.getCard(
      context,
      horarioInicio,
      horarioFim,
      nomeSala,
      professor,
      nota,
      titulo,
      data,
      () {
        firestore.apagarAgendamento(
          context: context, 
          nomeConjunto: idConjunto, 
          nomeSala: nomeSala, 
          dataAgendamento: data,
          tituloAgendamento: titulo
        );
      }
    );
  }
}
