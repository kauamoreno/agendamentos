import 'package:agendamentos/view_model/Sala/VM_SalasConjunto.dart';
import 'package:agendamentos/views/components/Cards/Cards.dart';
import 'package:agendamentos/views/pages/Erros/ErrorPage.dart';
import 'package:flutter/material.dart';
import '../../../components/CustomAppBar.dart';
import '../../../components/Forms.dart';
import '../../../components/TextFieldComponent.dart';
import '../../../constants/Cores.dart';

class GerenciaConjunto extends StatefulWidget {
  const GerenciaConjunto({super.key});

  @override
  State<GerenciaConjunto> createState() => _GerenciaConjuntoState();
}

class _GerenciaConjuntoState extends State<GerenciaConjunto> {

  TextFieldComponent textFieldComponent = TextFieldComponent();
  final _nomeConjuntoController = TextEditingController();
  final _subTituloConjuntoController = TextEditingController();
  ElementoCard cardElemento = ElementoCard();
  FormsPopUp formsPopUp = FormsPopUp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titulo: 'Gerenciar', voltar: true,),
      body: FutureBuilder(
        future: VM_SalasConjunto().gerenciarSalasConjunto(context),
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());

          } else if (snapshot.hasError) {
            return ErrorPage(erroMensagem: snapshot.error);

          } else {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Cores.fundoCard,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(
                          Icons.room_preferences_rounded,
                          color: Cores.letraCard,
                          size: 75,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: Text('Gerenciar Conjunto\nde Salas', textAlign: TextAlign.center, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Cores.letraCard))
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 70),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: snapshot.data ?? [],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          formsPopUp.formsConjunto(
            context: context,
            tituloController: _nomeConjuntoController,
            subtituloController: _subTituloConjuntoController,
            funcaoCreate: (){
              VM_SalasConjunto().cadastrarConjunto(
                context,
                _nomeConjuntoController.text,
                _subTituloConjuntoController.text
              );
            },
            setState: () {setState(() {});}
          );
        },
        
        child: Icon(Icons.add_business, size: 40),
        backgroundColor: Cores.azul,
      )
    );
  }
}