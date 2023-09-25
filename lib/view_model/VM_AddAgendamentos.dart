import 'package:flutter/material.dart';
import '../models/services/Firestore/SalasFirestore.dart';

class VM_AddAgendamentos {

  final String nomeConjunto;
  final String nomeSala;

  VM_AddAgendamentos({
    required this.nomeConjunto,
    required this.nomeSala
  });

  SalasFirestore fire = SalasFirestore(); 

  validaDados({
    required BuildContext context,
    required String titulo,
    String ?nota,
    required String data,
    required String timeInicial,
    required String timeFinal,
    required String lembrete
  }) {

    if(titulo.isNotEmpty /*Ver se não tem horarios iguais*/){
      fire.criarAgendamento(
        context: context, 
        nomeConjunto: nomeConjunto, 
        nomeSala: nomeSala,
        titulo: titulo, 
        data: data, 
        timeInicial: timeInicial, 
        timeFinal: timeFinal, 
        lembrete: lembrete
      ); 
    }
    
  }
}
