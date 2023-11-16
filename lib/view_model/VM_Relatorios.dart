import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class VM_Relatorios {
  final CollectionReference<Map<String, dynamic>> db = FirebaseFirestore.instance.collection('salaConjunto');

  Future<Map<String, int>> getTotalAgendamentosPorDiaSemanaAtual() async {
    final Map<String, int> totalPorDia = {
      'segunda-feira': 0,
      'terça-feira': 0,
      'quarta-feira': 0,
      'quinta-feira': 0,
      'sexta-feira': 0,
      'sábado': 0,
    };

    final DateTime hoje = DateTime.now();
    final DateTime inicioSemana = hoje.subtract(Duration(days: hoje.weekday - 1)); // Primeiro dia desta semana
    final DateTime fimSemana = inicioSemana.add(const Duration(days: 6)); // Último dia desta semana

    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await db.get();

      for (var doc in querySnapshot.docs) {
        final salas = doc['Salas'] as List<dynamic>?;

        if (salas != null) {
          for (var sala in salas) {
            final agendamentos = sala['agendamentos'] as List<dynamic>?;

            if (agendamentos != null) {
              for (var agendamento in agendamentos) {

                String dataAgendamentoString = agendamento['data'] as String;
                DateTime dataAgendamentoConverted = DateFormat('dd/MM/yyyy').parse(dataAgendamentoString);
                
                if (dataAgendamentoConverted.isAfter(inicioSemana) && dataAgendamentoConverted.isBefore(fimSemana.add(const Duration(days: 1)))) {
                  final String diaSemana = DateFormat('EEEE', 'pt_BR').format(dataAgendamentoConverted);

                  if (diaSemana != 'Domingo' && totalPorDia.containsKey(diaSemana)) {
                    totalPorDia[diaSemana] = totalPorDia[diaSemana]! + 1;
                  }
                }
              }
            }
          }
        }
      }

      return totalPorDia;
    } catch (e) {
      
      print("Erro ao obter o total de agendamentos: $e");
      return totalPorDia;
    }
  }
}
