import 'package:agendamentos/view_model/Sala/VM_Salas.dart';
import 'package:agendamentos/views/components/SalasCard.dart';
import 'package:flutter/material.dart';
import '../components/TextFieldComponent.dart';
import '../components/CustomAppBar.dart';
import 'Erros/ErrorPage.dart';

class TelaSalas extends StatefulWidget {
  final String nomeConjunto;
  const TelaSalas({
    super.key, 
    required this.nomeConjunto
  });

  @override
  State<TelaSalas> createState() => _TelaSalasState();
}

class _TelaSalasState extends State<TelaSalas> {
  
  TextFieldComponent textFieldComponent = TextFieldComponent();
  final _pesquisaController = TextEditingController();
  SalasCard salasCard = SalasCard();
  late VM_Salas vm;

  @override
  void initState() {
    super.initState();
    vm = VM_Salas(nomeConjunto: widget.nomeConjunto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titulo: 'Salas', voltar: true),
      body: FutureBuilder(

        future: vm.mostrarSalas(context),
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
