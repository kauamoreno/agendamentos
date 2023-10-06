import 'package:agendamentos/view_model/SnackBarViewModel.dart';
import 'package:agendamentos/views/components/CardAgendamento.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class VM_Calendario {
  final String nomeConjunto;
  final String nomeSala;

  VM_Calendario({
    required this.nomeConjunto,
    required this.nomeSala,
  });

  SnackBarViewModel snack = SnackBarViewModel();
  CardAgendamento cardAgendamento = CardAgendamento();

  Future<List<Widget>> getAgendamentos(BuildContext context, DateTime dataSelecionada) async {
    List<Widget> agendamentoWidgets = [];

    try {
      DocumentReference salaConjuntoDocRef = FirebaseFirestore.instance.collection('salaConjunto').doc(nomeConjunto);
      DocumentSnapshot salaConjuntoDoc = await salaConjuntoDocRef.get();

      if (salaConjuntoDoc.exists) {
        final salaConjuntoData = salaConjuntoDoc.data() as Map<String, dynamic>?;

        if (salaConjuntoData != null) {
          final salas = salaConjuntoData['Salas'] as List<dynamic>?;

          if (salas != null) {
            // Encontra a sala específica com base no nome
            final salaEspecifica = salas.firstWhere((sala) => sala['nome'] == nomeSala,orElse: () => null);

            if (salaEspecifica != null) {
              final agendamentos = salaEspecifica['agendamentos'] as List<dynamic>?;

              if (agendamentos != null) {
                
                // Filtra os agendamentos que correspondem à data selecionada no formato "yyyy-MM-dd"
                final agendamentosNoDia = agendamentos.where((agendamento) {
                  final dataSelecionadaFormatada = DateFormat('dd/MM/yyyy').format(dataSelecionada);
                  final dataAgendamento = agendamento['data'];

                  return dataAgendamento == dataSelecionadaFormatada;
                }).toList();

                // Cria widgets de card para os agendamentos do dia
                for (var agendamento in agendamentosNoDia) {

                  final card = cardAgendamento.getCard(
                    context,
                    agendamento['timeInicial'],
                    agendamento['timeFinal'],
                    nomeSala,
                    agendamento['professor'],
                    agendamento['nota'],
                  );

                  agendamentoWidgets.add(card);
                }
              }
            }
          }
        }
      }
    } catch (error) {
      snack.erro(context, 'Erro ao obter agendamentos: $error');
    }

    return agendamentoWidgets;
  }
}
