import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String titulo;
  final String dica;
  final TextEditingController? controller;
  final Widget? widget;
  final VoidCallback? onTapCallback;
  final bool desativado;
  final Color corBorda;
  final Color corTexto;

  const Input({
    Key? key,
    required this.titulo,
    required this.dica,
    this.controller,
    this.widget,
    this.onTapCallback, 
    this.desativado = false,
    this.corBorda = Colors.grey,
    this.corTexto = Colors.black
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
            Text(titulo, style: TextStyle(fontWeight: FontWeight.bold, color: corTexto)),
            Container(
              height: 52,
              margin: const EdgeInsets.only(top: 8.0),
              padding: const EdgeInsets.only(left: 14),
              decoration: BoxDecoration(
                border: Border.all(color: corBorda, width: 1.0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AbsorbPointer(
                      absorbing: desativado,
                      child: TextFormField(
                        autofocus: false,
                        cursorColor: corBorda,
                        controller: controller,
                        style: TextStyle(color: corTexto),
                        decoration: InputDecoration(
                          hintText: dica,
                          hintStyle: TextStyle(color: corTexto.withAlpha(100)),
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
