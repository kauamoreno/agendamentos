import 'package:flutter/material.dart';
//RESTO DO CODIGO NO GPT

class CustomCard extends StatelessWidget {
  final String horario;
  final String sala;
  final String nota;
  final String professor;
  final VoidCallback? onTap;

  CustomCard({
    required this.horario,
    required this.sala,
    required this.nota,
    required this.professor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 155.0, // Altura personalizada
      child: Card(
        elevation: 5, // Sombra
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Borda arredondada
        ),
        color: Colors.blue, // Cor de fundo
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Alinhamento à esquerda
              children: <Widget>[
                Container(
                  width: 2.0, // Largura da linha decorativa
                  color: Colors.white, // Cor da linha decorativa
                  margin: EdgeInsets.only(right: 16.0), // Espaçamento à direita
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Horário: $horario',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0), // Espaçamento
                    Text(
                      'Sala: $sala',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0), // Espaçamento
                    Text(
                      'Nota: $nota',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0), // Espaçamento
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
}
