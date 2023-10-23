import 'package:agendamentos/view_model/Usuarios/VM_Usuarios.dart';
import 'package:agendamentos/views/components/CustomAppBar.dart';
import '../../../components/Cards/Cards.dart';
import '../../../components/Forms.dart';
import 'package:agendamentos/views/constants/Cores.dart';
import 'package:flutter/material.dart';
import '../../Erros/ErrorPage.dart';

class GerenciarProf extends StatefulWidget {
  const GerenciarProf({super.key});

  @override
  State<GerenciarProf> createState() => _GerenciarProfState();
}

class _GerenciarProfState extends State<GerenciarProf> {

  FormsPopUp formsPopUp = FormsPopUp();
  ElementoCard cardElemento = ElementoCard();
  final _nomeProfController = TextEditingController();
  final _emailProfController = TextEditingController();
  final _senhaProfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titulo: 'Gerenciar', voltar: true),
      body: FutureBuilder(
        future: GerenciarUsuario().mostrarUsuarios(context),
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
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
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
                        Icon(
                          Icons.manage_accounts,
                          color: Cores.letraCard,
                          size: 75,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: Text('Gerenciar\nProfessores', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Cores.letraCard))
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 70),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children:
                              snapshot.data ?? [],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Limpar forms ao abrir novamente
          _nomeProfController.text = "";
          _emailProfController.text = "";
          _senhaProfController.text = "";
          
          //Abrir forms
          formsPopUp.formsProfessor(
            context: context, 
            nomeProfController: _nomeProfController, 
            emailProfController: _emailProfController, 
            senhaProfController: _senhaProfController,
            funcaoCreate: () {
              GerenciarUsuario().cadastro(
                context,
                _nomeProfController.text,
                _emailProfController.text,
                _senhaProfController.text
              );
            },
            setState: () {setState(() {});}
          );
        },
        child: Icon(Icons.person_add_alt_sharp, size: 40),
        backgroundColor: Cores.azul,
      )
    );
  }
}