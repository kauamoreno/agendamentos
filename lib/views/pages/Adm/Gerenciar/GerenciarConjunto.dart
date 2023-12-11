import 'package:agendamentos/view_model/Sala/VM_SalasConjunto.dart';
import 'package:agendamentos/views/components/Cards/Cards.dart';
import 'package:agendamentos/views/components/HeaderApp.dart';
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
  final _linkController = TextEditingController();
  ElementoCard cardElemento = ElementoCard();
  FormsPopUp formsPopUp = FormsPopUp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titulo: 'Gerenciar Conjuntos', voltar: true,),
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
                HeaderApp(context, Icons.room),
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
          _nomeConjuntoController.text = '';
          _subTituloConjuntoController.text = '';
          _linkController.text = '';
          formsPopUp.formsConjunto(
            context: context,
            tituloController: _nomeConjuntoController,
            subtituloController: _subTituloConjuntoController,
            linkController: _linkController,
            funcaoCreate: (){
              VM_SalasConjunto().cadastrarConjunto(
                context,
                _nomeConjuntoController.text,
                _subTituloConjuntoController.text,
                _linkController.text
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