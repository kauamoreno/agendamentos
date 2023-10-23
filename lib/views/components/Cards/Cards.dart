import 'package:flutter/material.dart';
import '../../constants/Cores.dart';

class ElementoCard {
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
                            child: Text('Editar', style: TextStyle(fontSize: 16)),
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
                                    child: Text('Deseja excluir este item permanentemente?', style: TextStyle(fontSize: 16))
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text('Cancelar', style: TextStyle(fontSize: 16, color: Cores.red)),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    TextButton(
                                      child: Text('EXCLUIR', style: TextStyle(fontSize: 16, color: Cores.red)),
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
                            child: Text('Excluir', style: TextStyle(fontSize: 16))
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
    Text infoProf = Text('$nome\n$email', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
    BoxDecoration caixaFoto = BoxDecoration(shape: BoxShape.circle);
    Padding botaoExtra =
      Padding(
        padding: 
          EdgeInsetsDirectional.symmetric(horizontal: 5),
        child: ElevatedButton(
          onPressed: () {
            print('Ver Agendas');
          },
          child: Text('Ver Agendas', style: TextStyle(fontSize: 16, color: Cores.black)),//elementoTexto.escreverTexto(texto: 'Ver Agendas', corFonte: Cores.black),
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
    Text infoSala = Text('$nome\n$quantidade Lugares', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
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
    Text infoConjunto = Text('$nome\n$subtitulo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));//elementoTexto.escreverTexto(texto: '$nome\n$subtitulo', expessura: FontWeight.bold, tamanho: 20);
    BoxDecoration caixaFoto = BoxDecoration(shape: BoxShape.circle);
    Padding botaoExtra =
      Padding(
        padding: 
          EdgeInsetsDirectional.symmetric(horizontal: 5),
        child: ElevatedButton(
          onPressed: () {
            verSalas();
          },
          child: Text('Ver Salas', style: TextStyle(fontSize: 16, color: Cores.black)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Cores.fundoCard
          )
        )
      );

    editarConjunto;

    return _Card(context, caixaFoto, foto, 100, infoConjunto, id, botaoExtra, deletarConjunto, editarConjunto);
  }
}