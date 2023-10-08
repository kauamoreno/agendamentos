import 'package:agendamentos/view_model/Sala/VM_SalasConjunto.dart';
import 'package:agendamentos/views/components/Cards.dart';
import 'package:agendamentos/views/pages/Erros/ErrorPage.dart';
import 'package:flutter/material.dart';
import '../components/CustomAppBar.dart';
import '../components/TextFieldComponent.dart';
import '../components/Texto.dart';
import '../constants/Cores.dart';

class GerenciaConjunto extends StatefulWidget {
  const GerenciaConjunto({super.key});

  @override
  State<GerenciaConjunto> createState() => _GerenciaConjuntoState();
}

class _GerenciaConjuntoState extends State<GerenciaConjunto> {

  ElementoTexto elementoTexto = ElementoTexto();
  TextFieldComponent textFieldComponent = TextFieldComponent();
  final _nomeConjuntoController = TextEditingController();
  final _tipoConjuntoController = TextEditingController();
  ElementoCard cardElemento = ElementoCard();

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
                          child: elementoTexto.escreverTexto(
                            texto: 'Gerenciar Conjunto\nde Salas',
                            alinhamento: TextAlign.center,
                            tamanho: 25,
                            expessura: FontWeight.bold,
                            corFonte: Cores.letraCard
                          ),
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
          showDialog(context: context, builder: (context) => 
            AlertDialog(
              content: Form(
                child: Container(
                  height: 200,
                  child: Column(
                    children: [
                      textFieldComponent.textFieldCustom(label: 'Nome do Conjunto', icone: Icons.abc, hint: 'Ex. Mecânica, TI, Elétrica', controller: _nomeConjuntoController),
                      textFieldComponent.textFieldCustom(label: 'Descrição do Conjunto', icone: Icons.room, hint: 'Ex. Salas que contém X maquina', controller: _tipoConjuntoController),
                    ],
                  ),
                )
              ),
              actions: [
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: const Text('Enviar'),
                  onPressed: () {
                    print('criar');
                  }
                ), 
              ],
            )
          );
        },
        
        child: Icon(Icons.add_business, size: 40),
        backgroundColor: Cores.azul,
      )
    );
  }
}