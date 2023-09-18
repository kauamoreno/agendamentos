import 'package:flutter/material.dart';

import '../components/CustomAppBar.dart';
import '../components/TextFieldComponent.dart';
import '../components/Texto.dart';
import '../constants/Cores.dart';

class GerenciaSala extends StatefulWidget {
  const GerenciaSala({super.key});

  @override
  State<GerenciaSala> createState() => _GerenciaSalaState();
}

class _GerenciaSalaState extends State<GerenciaSala> {
  ElementoTexto elementoTexto = ElementoTexto();
  TextFieldComponent textFieldComponent = TextFieldComponent();
  final _nomeSalaController = TextEditingController();
  final _tipoSalaController = TextEditingController();
  final _quantidadeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titulo: 'Gerenciar'),
      body: Column(
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
                    Icons.room_preferences_rounded,
                    color: Cores.letraCard,
                    size: 75,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
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
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.6,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                              child: Container(
                                width: 150,
                                height: 150,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                child: Image.network(
                                  'https://suzano.sp.senai.br/galeriaimagens/imageviewer.ashx?Url=67222',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                      EdgeInsetsDirectional.fromSTEB(0, 0, 5, 5),
                                    child: elementoTexto.escreverTexto(
                                      texto: 'Sala 1\nSalas de Aula\n32 Lugares',
                                      expessura: FontWeight.w900,
                                      tamanho: 18
                                    )
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: 
                                          EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            print('Editar');
                                          },
                                          child: Text('Editar'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Cores.azul
                                          )
                                        )
                                      ),
                                      Padding(
                                        padding: 
                                          EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            showDialog(context: context, builder: (context) => 
                                              AlertDialog(
                                                content: Form(
                                                  child: elementoTexto.escreverTexto(
                                                    texto: 'Deseja excluir este item permanentemente?'
                                                  )
                                                ),
                                                actions: [
                                                  TextButton(
                                                    child: const Text('Cancelar'),
                                                    onPressed: () => Navigator.pop(context),
                                                  ),
                                                  TextButton(
                                                    child: const Text('EXCLUIR'),
                                                    onPressed: () {}
                                                  ), 
                                                ],
                                              )
                                            );
                                          },
                                          child: Text('Excluir')
                                        )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
                  onPressed: () {}
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