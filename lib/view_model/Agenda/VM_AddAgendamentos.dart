import 'package:agendamentos/view_model/SnackBarViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/services/Firestore/SalasFirestore.dart';

class VM_AddAgendamentos {

  final String nomeConjunto;
  final String nomeSala;

  VM_AddAgendamentos({
    required this.nomeConjunto,
    required this.nomeSala
  });

  SalasFirestore fire = SalasFirestore(); 
  SnackBarViewModel snack = SnackBarViewModel();

  validaDados({
    required BuildContext context,
    String ?nota,
    required String data,
    required String titulo,
    required String timeInicial,
    required String timeFinal,
    required String nomeProfessor,
    required String idProfessor,
  }) async {

    if(titulo.isNotEmpty){
      if(isHorarioValido(timeInicial, timeFinal)){
        if(await semConflitoDeAgendamento(context, data, timeInicial, timeFinal)) {
          // ignore: use_build_context_synchronously
          fire.criarAgendamento(
            context: context, 
            idProfessor: idProfessor,
            nomeConjunto: nomeConjunto, 
            nomeSala: nomeSala,
            data: data, 
            nota: nota,
            titulo: titulo,
            timeInicial: timeInicial, 
            timeFinal: timeFinal, 
            nomeProfessor: nomeProfessor
          );
          Navigator.pop(context);
        } else { snack.erro(context, 'Horário ocupado, por favor escolher outro'); }
      } else { snack.erro(context, 'Horário Inválido'); }
    } else { snack.erro(context, 'Por favor, preencher com um título'); }
  }

  // Função para verificar se o horário inicial é menor que o horário final
  bool isHorarioValido(String horaInicial, String horaFinal) {
    DateTime horaInicialDateTime = DateFormat('HH:mm').parse(horaInicial);
    DateTime horaFinalDateTime = DateFormat('HH:mm').parse(horaFinal);

    return horaInicialDateTime.isBefore(horaFinalDateTime);
  }

  Future<bool> semConflitoDeAgendamento(BuildContext context, String dataSelecionada, String horaInicial, String horaFinal) async {
    try {
      DocumentReference salaConjuntoDocRef = FirebaseFirestore.instance.collection('salaConjunto').doc(nomeConjunto);
      DocumentSnapshot salaConjuntoDoc = await salaConjuntoDocRef.get();

      final salaConjuntoData = salaConjuntoDoc.data() as Map<String, dynamic>?;

      final salas = salaConjuntoData?['Salas'] as List<dynamic>?;
      final salaEspecifica = salas?.firstWhere((sala) => sala['nome'] == nomeSala, orElse: () => null);
      final agendamentos = salaEspecifica?['agendamentos'] as List<dynamic>?;

      if (agendamentos!.isNotEmpty) { // Esse agendamento tem que ser do dia que ele escolheu - ARRUMAR

        // Converte as strings de hora inicial, final e data 
        DateTime horaInicialDateTime = DateFormat('HH:mm').parse(horaInicial);
        DateTime horaFinalDateTime = DateFormat('HH:mm').parse(horaFinal);
        DateTime dataSelecionadaFormatada = DateFormat('dd/MM/yyyy').parse(dataSelecionada);

        // Filtra os agendamentos para obter apenas aqueles na data selecionada
        bool semHorariosConflitantes = agendamentos.any((agendamento) {
          final dataAgendamento = DateFormat('dd/MM/yyyy').parse(agendamento['data']); 
          final horaInicialAgendamento = DateFormat('HH:mm').parse(agendamento['timeInicial']);
          final horaFinalAgendamento = DateFormat('HH:mm').parse(agendamento['timeFinal']);

          // Verifica se há um conflito entre os horários
          return (dataAgendamento == dataSelecionadaFormatada && 
          (horaInicialAgendamento.isBefore(horaFinalDateTime) && horaFinalAgendamento.isAfter(horaInicialDateTime)));

        });

        return !semHorariosConflitantes;

      } else {
        return true;
      }
    } catch (error) {
      snack.erro(context, 'Erro ao obter agendamentos: $error');
      throw Exception('Erro ao obter agendamentos');
    }
  }

}
