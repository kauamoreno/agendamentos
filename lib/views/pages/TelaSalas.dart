import 'package:agendamentos/view_model/TelaSalas_ViewModel.dart';
import 'package:agendamentos/views/components/SalasCard.dart';
import 'package:flutter/material.dart';
import '../components/TextFieldComponent.dart';
import '../components/CustomAppBar.dart';
import 'Erros/ErrorPage.dart';

class TelaSalas extends StatefulWidget {
  const TelaSalas({Key? key}) : super(key: key);

  @override
  State<TelaSalas> createState() => _TelaSalasState();
}

class _TelaSalasState extends State<TelaSalas> {
  
  TextFieldComponent textFieldComponent = TextFieldComponent();
  final _pesquisaController = TextEditingController();
  SalasCard salasCard = SalasCard();
  TelaSalas_ViewModel telaSalas_ViewModel = TelaSalas_ViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titulo: 'Salas', voltar: true),
      body: FutureBuilder(

        future: telaSalas_ViewModel.mostrarSalasConjunto(context),
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());

          } else if (snapshot.hasError) {
            return ErrorPage(erroMensagem: snapshot.error);

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
