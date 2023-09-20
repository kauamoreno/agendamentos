import 'package:flutter/material.dart';
import '../../components/CustomAppBar.dart';
import 'package:agendamentos/views/components/botoes_homes.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titulo: 'Home - Professor'),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2, // 2 colunas
          children: [
            BotoesHome(context, 'Agenda', Icons.calendar_today,
                const Color.fromARGB(255, 235, 229, 229), '/calendario'),
            BotoesHome(context, 'Feedback', Icons.feedback,
                const Color.fromARGB(255, 235, 229, 229), '/feedback'),
            BotoesHome(context, 'Salas', Icons.room,
                const Color.fromARGB(255, 235, 229, 229), '/telaSalas'),
            BotoesHome(context, 'Notícias', Icons.new_releases,
                const Color.fromARGB(255, 235, 229, 229), '/noticias'),
          ],
        ),
      ),
    );
  }
}
