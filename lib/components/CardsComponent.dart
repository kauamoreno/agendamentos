import 'package:flutter/material.dart';
import '../constants/Cores.dart';

class CardsComponent {
  static Widget _CardsComponent(tipoSala, int disponivel, IconData icone) {
    String quantidade;
    quantidade = disponivel <= 1 ? 'disponível' : 'disponíveis';
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Cores.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icone,
              color: Color(0xFF650000),
              size: 64,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
              child: Text(
                '$tipoSala:\n($disponivel $quantidade)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  color: Color(0xFF650000),
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  CardFiltroSalas({required tipoSala, required int disponivel, required IconData icone}){
    return _CardsComponent(tipoSala, disponivel, icone);
  }
}
