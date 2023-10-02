import 'package:flutter/material.dart';

class CardAgendamento {
  Widget getCard(
    String horario, 
    String sala, 
    String professor, 
    VoidCallback? onTap
  ) {
    return Container(
      width: 450,
      height: 155.0,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), 
        ),
        color: Colors.blue,
        child: InkWell(
          onTap: onTap,
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
                      'Horário: $horario',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    
                    const SizedBox(height: 8.0),
                    
                    Text(
                      'Sala: $sala',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 8.0), 
                    
                    // Text(
                    //   'Nota: $nota',
                    //   style: TextStyle(
                    //     fontSize: 16.0,
                    //     color: Colors.white,
                    //   ),
                    // ),

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
}
