import 'package:agendamentos/views/constants/Texto.dart';
import 'package:flutter/material.dart';

class InputAgendamentos extends StatelessWidget {
  final String titulo;
  final String dica;
  final TextEditingController? controller;
  final Widget? widget;

  const InputAgendamentos({
    super.key, 
    required this.titulo,
    required this.dica,
    this.controller,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo),
          Container(
            height: 52,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      autofocus: false,
                      cursorColor: Colors.grey,
                      controller: controller,
                      style: subTituloStyle,
                      decoration: InputDecoration(
                        hintText: dica,
                        hintStyle: subTituloStyle,
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 0,
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  widget == null ? Container(): Container(
                    child: widget,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
