import 'package:flutter/material.dart';
import '../constants/Cores.dart';

class TextFieldComponent {
  static Widget _textFieldComponent(String label,  String hint, IconData icone, TextInputType textInputType, bool isSenha, Color cores, TextEditingController controller) {
    
    return TextField(
      keyboardType: textInputType,
      obscureText: isSenha,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(5),
          child: Icon(icone, color: cores),
        )
      ),
      controller: controller,
    );
  }
  
  textFieldEmail({required label, required String hint, required TextEditingController controller}){
    return _textFieldComponent(label, hint, Icons.email, TextInputType.emailAddress, false, Cores.white, controller);
  }

  textFieldSenha({required label, required String hint, required TextEditingController controller}){
    return _textFieldComponent(label, hint, Icons.password, TextInputType.visiblePassword, true,Cores.white, controller);
  }

  textFieldPesquisa({required label, required String hint, required TextEditingController controller}){
    return _textFieldComponent(label, hint, Icons.search, TextInputType.text, false,Cores.black, controller);
  }

  textFieldCustom({required label, required IconData icone, TextInputType tipoTeclado = TextInputType.text, required String hint, required TextEditingController controller}){
    return _textFieldComponent(label, hint, icone, TextInputType.text, false,Cores.black, controller);
  }
}
