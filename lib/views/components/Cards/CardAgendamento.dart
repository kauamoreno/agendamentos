import 'package:flutter/material.dart';
import '../../constants/Texto.dart';

class CardAgendamento {
  Widget getCard(
    BuildContext context, 
    String horarioInicial, 
    String horarioFinal, 
    String sala, 
    String professor, 
    String ?nota, 
    String titulo, 
  ) {
    return SizedBox(
      width: 450,
      height: 120.0,

      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.blue,

        child: InkWell(
          onTap: () {
            _mostraModal(
              context, 
              horarioInicial,
              horarioFinal,
              sala,
              professor,
              nota,
              titulo
            );
          },

          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 2.0,
                  color: Colors.white,
                  margin: const EdgeInsets.only(right: 16.0),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Título: $titulo',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    Text(
                      'Horário: $horarioInicial ás $horarioFinal',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 8.0),

                    Text(
                      'Professor: $professor',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _mostraModal(
    BuildContext context, 
    String horarioInicial, 
    String horarioFinal, 
    String sala, 
    String professor,
    String ?nota,
    String titulo
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Detalhes do Agendamento', 
            style: tituloStyle
          ),
          
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Título: $titulo'),
              Text('Horário: $horarioInicial ás $horarioFinal'),
              Text('Sala: $sala'),
              Text('Professor: $professor'),
              nota!.isNotEmpty ? Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text('Nota: $nota'),
              ) : Container()
            ],
          ),

          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o modal quando o botão é clicado
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
