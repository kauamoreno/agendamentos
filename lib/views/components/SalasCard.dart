import 'package:flutter/material.dart';
import '../constants/Cores.dart';

class SalasCard {

  static Widget SalasConjuntoComponent(BuildContext context, String titulo, String subTitulo, String imgUrl) { 
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () => print("clicado"),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Cores.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(imgUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$titulo', style: TextStyle(fontSize: 25)),
                        Text('$subTitulo', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  salaConjunto({required BuildContext context, required String titulo, required String subTitulo, required String imgUrl}){
    return SalasConjuntoComponent(context, titulo, subTitulo, imgUrl);
  }
}