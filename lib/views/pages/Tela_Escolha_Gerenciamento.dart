import 'package:agendamentos/views/components/CustomAppBar.dart';
import 'package:agendamentos/views/components/botoes_homes.dart';
import 'package:flutter/material.dart';


class TelaEscolhaGerenciamento extends StatefulWidget {
  const TelaEscolhaGerenciamento({super.key});

  @override
  State<TelaEscolhaGerenciamento> createState() => _TelaEscolhaGerenciamentoState();
}

class _TelaEscolhaGerenciamentoState extends State<TelaEscolhaGerenciamento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titulo: 'Gerenciar', voltar: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 1, //
                children: <Widget>[
                  BotoesHome(context, 'Gerenciar Professores', Icons.settings, Colors.grey, '/gerenciarProfessores'),
                  BotoesHome(context, 'Gerenciar Salas', Icons.settings, Colors.grey, '/gerenciarConjunto'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}