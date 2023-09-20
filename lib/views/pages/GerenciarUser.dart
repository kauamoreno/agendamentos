import 'package:agendamentos/views/components/CustomAppBar.dart';
import 'package:agendamentos/views/components/Texto.dart';
import 'package:agendamentos/views/constants/Cores.dart';
import 'package:flutter/material.dart';

class GerenciarProf extends StatefulWidget {
  const GerenciarProf({super.key});

  @override
  State<GerenciarProf> createState() => _GerenciarProfState();
}

class _GerenciarProfState extends State<GerenciarProf> {
  ElementoTexto elementoTexto = ElementoTexto();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(titulo: 'Gerenciamento de Professores'),
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
                      Icons.manage_accounts,
                      color: Cores.letraCard,
                      size: 75,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: elementoTexto.escreverTexto(
                          texto: 'Gerenciar\nProfessores',
                          alinhamento: TextAlign.center,
                          tamanho: 20,
                          expessura: FontWeight.bold,
                          corFonte: Cores.letraCard),
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://www.offidocs.com/images/xtwitterdefaultpfpicon.jpg.pagespeed.ic.9q2wXBQmsW.jpg',
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
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 5, 5),
                                        child: elementoTexto.escreverTexto(
                                            texto:
                                                'CARLOS FERREIRA DE SOUZA\nProfessor\nSenai Nami Jafet 117',
                                            expessura: FontWeight.w900,
                                            tamanho: 18)),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5, 0, 5, 0),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  print('Editar');
                                                },
                                                child: Text('Editar'),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Cores.azul))),
                                        Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5, 0, 5, 0),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  print('Excluir');
                                                },
                                                child: Text('Excluir'))),
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
            print('Adicionar');
          },
          child: Icon(Icons.person_add_alt_sharp, size: 40),
          backgroundColor: Cores.azul,
        ));
  }
}
