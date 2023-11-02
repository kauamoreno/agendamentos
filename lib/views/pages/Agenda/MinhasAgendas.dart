import 'package:agendamentos/view_model/Agenda/VM_MinhasAgendas.dart';
import 'package:agendamentos/views/components/CustomAppBar.dart';
import 'package:agendamentos/views/components/HeaderApp.dart';
import 'package:agendamentos/views/pages/Erros/ErrorPage.dart';
import 'package:flutter/material.dart';

class MinhasAgendas extends StatefulWidget {
  final String idProfessor;
  const MinhasAgendas({
    super.key,
    required this.idProfessor
  });

  @override
  State<MinhasAgendas> createState() => _MinhasAgendasState();
}

class _MinhasAgendasState extends State<MinhasAgendas> {
  VM_MinhasAgendas vm = VM_MinhasAgendas();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titulo: 'Minhas Agendas', voltar: true),
      body: FutureBuilder(
        future: vm.minhasAgendas(context: context, idProfessor: widget.idProfessor),
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());

          } else if (snapshot.hasError) {
            return ErrorPage(erroMensagem: snapshot.error);
            
          } else {
            return Column(
              children: [
                HeaderApp(context, Icons.calendar_today),
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: snapshot.data ?? [], // Lista de widgets de cards.
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
