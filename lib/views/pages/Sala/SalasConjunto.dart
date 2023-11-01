import 'package:agendamentos/view_model/Sala/VM_SalasConjunto.dart';
import 'package:agendamentos/views/components/Cards/SalasCard.dart';
import 'package:agendamentos/views/components/HeaderApp.dart';
import 'package:flutter/material.dart';
import '../../components/TextFieldComponent.dart';
import '../../components/CustomAppBar.dart';
import '../Erros/ErrorPage.dart';

class SalasConjunto extends StatefulWidget {
  const SalasConjunto({Key? key}) : super(key: key);

  @override
  State<SalasConjunto> createState() => _SalasConjuntoState();
}

class _SalasConjuntoState extends State<SalasConjunto> {
  
  TextFieldComponent textFieldComponent = TextFieldComponent();
  SalasCard salasCard = SalasCard();
  VM_SalasConjunto vm = VM_SalasConjunto();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titulo: 'Salas', voltar: true),
      body: FutureBuilder(

        future: vm.mostrarSalasConjunto(context),
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());

          } else if (snapshot.hasError) {
            return ErrorPage(erroMensagem: snapshot.error);

          } else {
            return Column(
              children: [
                HeaderApp(context, Icons.room),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: snapshot.data ?? [], // Lista de widgets de cards.
                    ),
                  )
                )
              ],
            );
          }
        },
      ),
    );
  }
}
