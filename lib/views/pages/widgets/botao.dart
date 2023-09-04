import 'package:agendamentos/views/pages/Temas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const Botao({Key? key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: primaryClr),
        child: Align(
          alignment: Alignment.center,
          child: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 20),
          )
          
        ),
      ),
    );
  }
}
