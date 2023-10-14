import 'package:flutter/material.dart';
import 'TextFieldComponent.dart';

class FormsPopUp {
  TextFieldComponent textFieldComponent = TextFieldComponent();
  _forms(BuildContext context, Column colunaForms, Function funcao, Function setState) {
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
              Future.delayed(const Duration(seconds: 2), () {
                setState();
              });
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
    required Function funcaoCreate,
    required Function setState
  }) {
    Column colunaForms = 
      Column(
        children: [
          textFieldComponent.textFieldCustom(label: 'Nome do Professor', icone: Icons.abc, hint: 'Nome Completo', controller: nomeProfController),
          textFieldComponent.textFieldCustom(label: 'E-mail', icone: Icons.mail, hint: 'example@gmail.com', controller: emailProfController),
          textFieldComponent.textFieldCustom(label: 'Senha', icone: Icons.key, hint: 'Senha', mostrarSenha: true, controller: senhaProfController)
        ],
      );

    return _forms(context, colunaForms, funcaoCreate, setState);
  }

  formsConjunto({
    required BuildContext context, 
    required TextEditingController tituloController, 
    required TextEditingController subtituloController,
    required Function funcaoCreate,
    required Function setState
  }) {
    Column colunaForms = 
      Column(
        children: [
          textFieldComponent.textFieldCustom(label: 'Nome do Conjunto', icone: Icons.abc, hint: 'Ex. Mecânica, TI, Elétrica', controller: tituloController),
          textFieldComponent.textFieldCustom(label: 'Descrição do Conjunto', icone: Icons.mail, hint: 'Ex. Salas que contém "tal" objeto', controller: subtituloController)
        ],
      );

    return _forms(context, colunaForms, funcaoCreate, setState);
  }

  formsSala({
    required BuildContext context,
    required TextEditingController nomeSalaController,
    required TextEditingController quantidadeController,
    required String uidConjunto,
    required Function funcaoCreate,
    required Function setState,
    // required String valorSelecionado,
    // required Function array,
  }) {
    Column colunaForms =
      Column(
        children: [
          textFieldComponent.textFieldCustom(label: 'Nome da Sala', icone: Icons.abc, hint: 'Sala 1', controller: nomeSalaController),
          textFieldComponent.textFieldCustom(label: 'Quantidade', icone: Icons.person, hint: '32 Lugares', controller: quantidadeController, tipoTeclado: TextInputType.number)
        ],
      );

    return _forms(context, colunaForms, funcaoCreate, setState);
  }
}