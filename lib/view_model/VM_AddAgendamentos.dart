import 'package:flutter/material.dart';
import '../models/services/Firestore/SalasFirestore.dart';

class VM_AddAgendamentos {

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

    if(titulo.isNotEmpty){
      // fire.criarAgendamento(
      //   context: context, 
      //   nomeConjunto: nomeConjunto, // doc.id
      //   nomeSala: nomeSala, // PRECISA VER
      //   titulo: titulo, 
      //   data: data, 
      //   timeInicial: timeInicial, 
      //   timeFinal: timeFinal, 
      //   lembrete: lembrete
      // ); 
    }
    
    print(
      '---------------------------------------------------------------------- \n Titulo: $titulo \n Nota: $nota \n Data: $data \n Inicio: $timeInicial \n Final: $timeFinal \n Lembrete: $lembrete',
    );
    
  }
}
