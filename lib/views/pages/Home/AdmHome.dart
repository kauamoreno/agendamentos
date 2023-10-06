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
            BotoesHome(context, 'Agenda', Icons.calendar_today, Colors.grey,'/calendario'),
            BotoesHome(context, 'Feedback', Icons.feedback, Colors.grey, '/feedback'),
            BotoesHome(context, 'Salas', Icons.room, Colors.grey, '/salasConjunto'),
            BotoesHome(context, 'Notícias', Icons.new_releases, Colors.grey,'/noticias'),
            BotoesHome(context, 'Relatório', Icons.insert_chart, Colors.grey,'/relatorio'),
            BotoesHome(context, 'Gerenciamento', Icons.settings, Colors.grey,'/escolhaDeGerenciamento'),
          ],
        ),
      ),
    );
  }
}
