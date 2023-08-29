import 'package:flutter/material.dart';

class DialogoAlerta extends StatefulWidget {
  const DialogoAlerta({super.key});

  @override
  State<DialogoAlerta> createState() => _DialogoAlertaState();
}

class _DialogoAlertaState extends State<DialogoAlerta> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        // key: _formKey,
        child: TextFormField(
          // controller: _controller,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            hintText: 'Forneça o seu feedback',
            filled: true,
          ),
          maxLines: 5,
          maxLength: 4096,
          textInputAction: TextInputAction.done,
          validator: (String? text) {
            if (text == null || text.isEmpty) {
              return 'Porfavor, coloque um valor';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text('Enviar'),
          onPressed: (){}
        ),   
      ],
    );
  }
}
