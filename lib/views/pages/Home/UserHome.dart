import 'package:agendamentos/view_model/UserHome_ViewModel.dart';
import 'package:agendamentos/views/components/SalasCard.dart';
import 'package:flutter/material.dart';
import '../../components/TextFieldComponent.dart';
import '../../components/CustomAppBar.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  
  TextFieldComponent textFieldComponent = TextFieldComponent();
  final _pesquisaController = TextEditingController();
  SalasCard salasCard = SalasCard();
  UserHome_ViewModel userHome_ViewModel = UserHome_ViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titulo: 'Home'),
      body: FutureBuilder(

        future: userHome_ViewModel.mostrarSalasConjunto(context),
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());

          } else if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');

          } else {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
              child: Column(
                children: [
                  textFieldComponent.textFieldPesquisa(
                    label: "Pesquisa",
                    hint: 'Pesquisa...',
                    controller: _pesquisaController
                  ),

                  const SizedBox(height: 30), //Espaço

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: snapshot.data ?? [], // Lista de widgets de cards.
                      ),
                    )
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
