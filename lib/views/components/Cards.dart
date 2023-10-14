import 'package:flutter/material.dart';
import '../constants/Cores.dart';
import 'Texto.dart';

class ElementoCard {
  ElementoTexto elementoTexto = ElementoTexto();
  _Card(BuildContext context, BoxDecoration caixaFoto, String foto, double tamanhoFoto, Text label, String id, Padding botaoExtra, Function funcaoDeletar, Function funcaoEditar) {
    return Card(
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
            padding: EdgeInsetsDirectional.all(5),
            child: Container(
              width: tamanhoFoto,
              height: tamanhoFoto,
              clipBehavior: Clip.antiAlias,
              decoration: caixaFoto,
              child: Image.network(
                foto,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding:
                      EdgeInsetsDirectional.fromSTEB(0, 0, 5, 5),
                    child: label
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Padding(
                          padding: 
                            EdgeInsetsDirectional.symmetric(horizontal: 5),
                          child: ElevatedButton(
                            onPressed: () {
                              funcaoEditar();
                            },
                            child: elementoTexto.escreverTexto(texto: 'Editar', corFonte: Cores.white),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Cores.azul
                            )
                          )
                        ),
                      ),
                      PopupMenuItem(
                        child: Padding(
                          padding: 
                            EdgeInsetsDirectional.symmetric(horizontal: 5),
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
                                      child: elementoTexto.escreverTexto(texto: 'Cancelar', corFonte: Cores.red),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    TextButton(
                                      child: elementoTexto.escreverTexto(texto: 'EXCLUIR', corFonte: Cores.red),
                                      onPressed: () {
                                        funcaoDeletar();
                                        print(id);
                                        Navigator.pop(context);
                                      }
                                    ), 
                                  ],
                                )
                              );
                            },
                            child: elementoTexto.escreverTexto(texto: 'Excluir', corFonte: Cores.white)
                          )
                        ),
                      ),
                      PopupMenuItem(
                        child: botaoExtra,
                      ),
                    ]
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  cardProfessor({
    required BuildContext context, 
    required String nome, 
    required String email,
    required String id
  }) {
    Text infoProf = elementoTexto.escreverTexto(texto: '$nome\n$email', expessura: FontWeight.bold, tamanho: 18);
    BoxDecoration caixaFoto = BoxDecoration(shape: BoxShape.circle);
    Padding botaoExtra =
      Padding(
        padding: 
          EdgeInsetsDirectional.symmetric(horizontal: 5),
        child: ElevatedButton(
          onPressed: () {
            print('Ver Agendas');
          },
          child: elementoTexto.escreverTexto(texto: 'Ver Agendas', corFonte: Cores.black),
          style: ElevatedButton.styleFrom(
            backgroundColor: Cores.fundoCard
          )
        )
      );
      
    return _Card(context, caixaFoto, 'https://www.offidocs.com/images/xtwitterdefaultpfpicon.jpg.pagespeed.ic.9q2wXBQmsW.jpg', 120, infoProf, id, botaoExtra, (){}, (){});
  }
  
  cardSala({
    required BuildContext context, 
    required String nome,
    required int quantidade,
    required String foto,
    required String id,
    required Function deletarSala,
    required Function editarSala
  }) {
    Text infoSala = elementoTexto.escreverTexto(texto: '$nome\n$quantidade Lugares', expessura: FontWeight.bold, tamanho: 18);
    BoxDecoration caixaFoto = BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(8));
    Padding botaoExtra = Padding(padding: EdgeInsetsDirectional.zero);
      
    return _Card(context, caixaFoto, foto, 110, infoSala, id, botaoExtra, deletarSala, editarSala);
  }

  cardConjunto({
    required BuildContext context,
    required String nome,
    required String subtitulo,
    required String foto,
    required String id,
    required Function deletarConjunto,
    required Function editarConjunto,
    required Function verSalas
  }) {
    Text infoConjunto = elementoTexto.escreverTexto(texto: '$nome\n$subtitulo', expessura: FontWeight.bold, tamanho: 20);
    BoxDecoration caixaFoto = BoxDecoration(shape: BoxShape.circle);
    Padding botaoExtra =
      Padding(
        padding: 
          EdgeInsetsDirectional.symmetric(horizontal: 5),
        child: ElevatedButton(
          onPressed: () {
            verSalas();
          },
          child: elementoTexto.escreverTexto(texto: 'Ver Salas', corFonte: Cores.black),
          style: ElevatedButton.styleFrom(
            backgroundColor: Cores.fundoCard
          )
        )
      );

    editarConjunto;

    return _Card(context, caixaFoto, foto, 100, infoConjunto, id, botaoExtra, deletarConjunto, editarConjunto);
  }
}