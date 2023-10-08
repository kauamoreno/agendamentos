import 'package:agendamentos/views/constants/Texto.dart';
import 'package:flutter/material.dart';

class InputAgendamentos extends StatelessWidget {
  final String titulo;
  final String dica;
  final TextEditingController? controller;
  final Widget? widget;
  final VoidCallback? onTapCallback;
  final bool desativado;

  const InputAgendamentos({
    Key? key,
    required this.titulo,
    required this.dica,
    this.controller,
    this.widget,
    this.onTapCallback, 
    required this.desativado,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCallback,
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
            Container(
              height: 52,
              margin: const EdgeInsets.only(top: 8.0),
              padding: const EdgeInsets.only(left: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AbsorbPointer(
                      absorbing: desativado,
                      child: TextFormField(
                        autofocus: false,
                        cursorColor: Colors.grey,
                        controller: controller,
                        style: subTituloStyle,
                        decoration: InputDecoration(
                          hintText: dica,
                          hintStyle: subTituloStyle,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  widget == null ? Container() : Container(child: widget),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
