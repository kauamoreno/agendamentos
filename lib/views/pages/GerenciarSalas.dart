import 'package:agendamentos/view_model/Sala/VM_Salas.dart';
import 'package:agendamentos/views/pages/Erros/ErrorPage.dart';
import 'package:flutter/material.dart';
import '../components/CustomAppBar.dart';
import '../components/TextFieldComponent.dart';
import '../components/Texto.dart';
import '../constants/Cores.dart';

class GerenciaSala extends StatefulWidget {
  final String nomeConjunto;
  const GerenciaSala({
    super.key,
    required this.nomeConjunto
  });

  @override
  State<GerenciaSala> createState() => _GerenciaSalaState();
}

class _GerenciaSalaState extends State<GerenciaSala> {

  ElementoTexto elementoTexto = ElementoTexto();
  TextFieldComponent textFieldComponent = TextFieldComponent();
  final _nomeSalaController = TextEditingController();
  final _tipoSalaController = TextEditingController();
  final _quantidadeController = TextEditingController();
  late VM_Salas vm;

  @override
  void initState() {
    super.initState();
    vm = VM_Salas(nomeConjunto: widget.nomeConjunto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titulo: 'Gerenciar', voltar: true,),
      body: FutureBuilder(
        future: vm.mostraGerenciaSalas(context),
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
                            texto: 'Gerenciar\nSalas',
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
                      height: MediaQuery.sizeOf(context).height * 0.6,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: snapshot.data ?? [],
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
                      textFieldComponent.textFieldCustom(label: 'Nome da Sala', icone: Icons.abc, hint: 'Sala 1', controller: _nomeSalaController),
                      textFieldComponent.textFieldCustom(label: 'Tipo de Sala', icone: Icons.room, hint: 'Sala de Aula', controller: _tipoSalaController),
                      textFieldComponent.textFieldCustom(label: 'Quantidade', icone: Icons.person, hint: '32 Lugares', controller: _quantidadeController, tipoTeclado: TextInputType.number)
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