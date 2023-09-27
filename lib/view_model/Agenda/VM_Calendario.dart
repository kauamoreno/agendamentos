import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VM_Calendario {
  final String nomeConjunto;
  final String nomeSala;

  VM_Calendario({
    required this.nomeConjunto,
    required this.nomeSala,
  });

  Future<List<Widget>> getAgendamentos(BuildContext context, DateTime dataSelecionada) async {
    List<Widget> agendamentoWidgets = [];

    try {
      // Obtém a referência do documento da sala
      DocumentReference salaDocRef = FirebaseFirestore.instance.collection(nomeConjunto).doc(nomeSala);

      // Obtém o snapshot do documento da sala
      DocumentSnapshot salaDoc = await salaDocRef.get();

      if (salaDoc.exists) {
        final salaData = salaDoc.data() as Map<String, dynamic>?;
        final salas = salaData?['salas'] as List<dynamic>?;

        if (salas != null) {
          // Encontra a sala correta na lista de salas
          final salaIndex = salas.indexWhere((sala) => sala['nomeSala'] == nomeSala);

          if (salaIndex != -1) {
            final agendamentos = salas[salaIndex]['agendamentos'] as List<dynamic>?;

            // if (agendamentos != null) {
              
            //   // Filtra os agendamentos que correspondem à data selecionada
            //   final agendamentosNoDia = agendamentos.where((agendamento) {
            //     final dataAgendamento = DateTime.parse(agendamento['data']);
            //     return dataAgendamento.year == dataSelecionada.year &&
            //         dataAgendamento.month == dataSelecionada.month &&
            //         dataAgendamento.day == dataSelecionada.day;
            //   }).toList();

            //   // Cria widgets de card para os agendamentos do dia
            //   for (var agendamento in agendamentosNoDia) {
            //     final titulo = agendamento['titulo'];
            //     final horaInicial = agendamento['timeInicial'];
            //     final horaFinal = agendamento['timeFinal'];
            //     final lembrete = agendamento['lembrete'];

            //     // Crie um Card personalizado ou widget apropriado aqui com essas informações
            //     // Exemplo:
            //     final card = Card(
            //       child: ListTile(
            //         title: Text(titulo),
            //         subtitle: Text('Das $horaInicial às $horaFinal'),
            //         trailing: Text(lembrete),
            //       ),
            //     );

            //     agendamentoWidgets.add(card);
            //   }
            // }
          }
        }
      }
    } catch (error) {
      // Lida com erros aqui, por exemplo, exibindo uma mensagem de erro.
      print("Erro ao obter agendamentos: $error");
    }

    return agendamentoWidgets;
  }
}
