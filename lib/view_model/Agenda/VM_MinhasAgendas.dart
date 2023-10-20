import 'package:agendamentos/models/services/Autenticacao.dart';
import 'package:agendamentos/models/services/Firestore/SalasFirestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VM_MinhasAgendas {
  SalasFirestore firestore = SalasFirestore();
  Autenticacao auth = Autenticacao();

  Future<List<Widget>> minhasAgendas() async {
    String idProfessor = await auth.getIdNomeProfessorLogado(true) as String;

    List<Widget> agendamentosWidgets = [];

    try {
      QuerySnapshot<Map<String, dynamic>>? salasConjunto = await firestore.getSalasConjunto();

      for (QueryDocumentSnapshot salaConjuntoDoc in salasConjunto!.docs) {
        List<dynamic> salas = salaConjuntoDoc['Salas'] ?? [];

        for (dynamic sala in salas) {
          List<dynamic> agendamentos = sala['agendamentos'] ?? [];

          for (dynamic agendamento in agendamentos) {
            String idProfessorAgenda = agendamento['idProfessor'];

            if (idProfessorAgenda == idProfessor) {
              String titulo = agendamento['titulo'] ?? 'Sem título';
              String data = agendamento['data'] ?? 'Sem data';
              String horarioInicio = agendamento['timeInicial'] ?? 'Sem horário de início';
              String horarioFim = agendamento['timeFinal'] ?? 'Sem horário de término';

              // Crie o ListTile com os dados extraídos
              Container agendamentoTile = Container(
                child: Column(
                  children: [
                    Text('Título: $titulo'),
                    Text('Data: $data'),
                    Text('Horário de início: $horarioInicio'),
                    Text('Horário de término: $horarioFim'),
                    // Adicione mais informações aqui conforme necessário
                  ],
                ),
              );

              // Adicione o ListTile à lista
              agendamentosWidgets.add(agendamentoTile);
            }
          }
        }
      }
    } catch (error) {
      print('Erro ao obter agendamentos: $error');
    }

    return agendamentosWidgets;
  }
}
