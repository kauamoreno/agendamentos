import 'package:flutter/material.dart';
import 'TextFieldComponent.dart';

class FormsPopUp {
  TextFieldComponent textFieldComponent = TextFieldComponent();
  _forms(BuildContext context, Column colunaForms) {
    return showDialog(context: context, builder: (context) => 
      AlertDialog(
        content: Form(
          child: Container(
            height: 200,
            child: colunaForms
          )
        ),
        actions: [
          TextButton(
            child: const Text('Cancelar'),  
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Enviar'),
            onPressed: () {}
          ), 
        ],
      )
    );
  }
  
  formsProfessor({
    required BuildContext context, 
    required TextEditingController nomeProfController, 
    required TextEditingController cargoProfController, 
    required TextEditingController escolaProfController
  }) {
    Column colunaForms = 
      Column(
        children: [
          textFieldComponent.textFieldCustom(label: 'Nome do Professor', icone: Icons.abc, hint: '', controller: nomeProfController),
          textFieldComponent.textFieldCustom(label: 'Cargo', icone: Icons.co_present, hint: 'Professor', controller: cargoProfController),
          textFieldComponent.textFieldCustom(label: 'Escola', icone: Icons.room, hint: 'Nome da Escola', controller: escolaProfController, tipoTeclado: TextInputType.number)
        ],
      );

    return _forms(context, colunaForms);
  }
}