import 'package:flutter/material.dart';
import '../constants/Cores.dart';
import 'Texto.dart';

class ElementoCard {
  ElementoTexto elementoTexto = ElementoTexto();
  _Card(BuildContext context, BoxDecoration caixaFoto, String foto, double tamanhoFoto, Text label, String id) {
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                    EdgeInsetsDirectional.fromSTEB(0, 0, 5, 5),
                  child: label
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
                        child: elementoTexto.escreverTexto(texto: 'Editar', corFonte: Cores.white),
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
                                  child: elementoTexto.escreverTexto(texto: 'Cancelar', corFonte: Cores.red),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                TextButton(
                                  child: elementoTexto.escreverTexto(texto: 'EXCLUIR', corFonte: Cores.red),
                                  onPressed: () {
                                    
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
                  ],
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
      
    return _Card(context, caixaFoto, 'https://www.offidocs.com/images/xtwitterdefaultpfpicon.jpg.pagespeed.ic.9q2wXBQmsW.jpg', 120, infoProf, id);
  }
  
  cardSala({
    required BuildContext context, 
    required String nome, 
    required String tipo, 
    required int quantidade,
    required String foto,
    required String id
  }) {
    Text infoProf = elementoTexto.escreverTexto(texto: '$nome\n$tipo\n$quantidade Lugares', expessura: FontWeight.bold, tamanho: 18);
    BoxDecoration caixaFoto = BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(8));
      
    return _Card(context, caixaFoto, foto, 150, infoProf, id);
  }
}