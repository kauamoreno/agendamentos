import 'package:agendamentos/view_model/VM_Relatorios.dart';
import 'package:agendamentos/views/components/CustomAppBar.dart';
import 'package:agendamentos/views/components/GraficoDeBarras.dart';
import 'package:agendamentos/views/components/HeaderApp.dart';
import 'package:flutter/material.dart';

class RelatoriosPage extends StatefulWidget {
  @override
  _RelatoriosPageState createState() => _RelatoriosPageState();
}

class _RelatoriosPageState extends State<RelatoriosPage> {
  VM_Relatorios vm = VM_Relatorios();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titulo: 'Relatório', voltar: true),
      body: FutureBuilder(
        future: vm.getTotalAgendamentosPorDiaSemanaAtual(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, int>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar dados.'));
          } else {
            return Column(
              children: [
                HeaderApp(context, Icons.room),
                Container(height: 50),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GraficoDeBarras(snapshot)
                      ],
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
