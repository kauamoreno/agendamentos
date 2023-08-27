import 'package:agendamentos/views/components/SalasCard.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Container(color: Colors.blue, child: Center(child: SalasCard(imgUrl: 'https://suzano.sp.senai.br/galeriaimagens/imageviewer.ashx?Url=67222', titulo: "Sala 8", subTitulo: "Salas de Aula"))),
        ],
      ),
    );
  }
}
