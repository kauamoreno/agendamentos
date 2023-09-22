import 'package:flutter/material.dart';
import 'TextFieldComponent.dart';

class FormsPopUp {
  TextFieldComponent textFieldComponent = TextFieldComponent();
  _forms(BuildContext context, Column colunaForms, Function funcao) {
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
            onPressed: () {
              funcao();
            }
          ), 
        ],
      )
    );
  }
  
  formsProfessor({
    required BuildContext context, 
    required TextEditingController nomeProfController, 
    required TextEditingController emailProfController, 
    required TextEditingController senhaProfController,
    required Function funcaoCreate
  }) {
    Column colunaForms = 
      Column(
        children: [
          textFieldComponent.textFieldCustom(label: 'Nome do Professor', icone: Icons.abc, hint: 'Nome Completo', controller: nomeProfController),
          textFieldComponent.textFieldCustom(label: 'E-mail', icone: Icons.mail, hint: 'example@gmail.com', controller: emailProfController),
          textFieldComponent.textFieldCustom(label: 'Senha', icone: Icons.key, hint: 'Senha', controller: senhaProfController)
        ],
      );

    return _forms(context, colunaForms, funcaoCreate);
  }
}