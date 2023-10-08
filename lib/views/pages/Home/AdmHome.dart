import 'package:agendamentos/views/components/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:agendamentos/views/components/botoes_homes.dart';

class AdmHome extends StatefulWidget {
  const AdmHome({Key? key}) : super(key: key);

  @override
  State<AdmHome> createState() => _AdmHomeState();
}

class _AdmHomeState extends State<AdmHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titulo: "Home - Administrador"),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2, // 2 colunas
          children: <Widget>[
            BotoesHome(context, 'Agenda', Icons.calendar_today,
                Color.fromARGB(255, 233, 226, 226), '/calendario'),
            BotoesHome(context, 'Feedback', Icons.feedback,
                Color.fromARGB(255, 233, 226, 226), '/feedback'),
            BotoesHome(context, 'Salas', Icons.room,
                Color.fromARGB(255, 233, 226, 226), '/salasConjunto'),
            BotoesHome(context, 'Notícias', Icons.new_releases,
                Color.fromARGB(255, 233, 226, 226), '/noticias'),
            BotoesHome(context, 'Relatório', Icons.insert_chart,
                Color.fromARGB(255, 233, 226, 226), '/relatorio'),
            BotoesHome(context, 'Gerenciamento', Icons.settings,
                Color.fromARGB(255, 233, 226, 226), '/escolhaDeGerenciamento'),
          ],
        ),
      ),
    );
  }
}
