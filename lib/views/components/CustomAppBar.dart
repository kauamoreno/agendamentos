import 'package:agendamentos/view_model/SnackBarViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String titulo;

  const CustomAppBar({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titulo),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            showDialog(context: context, builder: (context) => DialogoAlerta());
          },
        )
      ],
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


//DialogoAlerta-----------------------------------------------------------------------------------
class DialogoAlerta extends StatefulWidget {

  @override
  State<DialogoAlerta> createState() => _DialogoAlertaState();
}

class _DialogoAlertaState extends State<DialogoAlerta> {
  SnackBarViewModel mensagemSnackBar = SnackBarViewModel();
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey(); 

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
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
          onPressed: ()async {
            if(_formKey.currentState!.validate()) {
              try {
                final collection = FirebaseFirestore.instance.collection('feedback');

                await collection.doc().set({
                  'timestamp': FieldValue.serverTimestamp(),
                  'feedback': _controller.text,
                });
                mensagemSnackBar.sucesso(context, 'Feedback enviado');
                Navigator.pop(context);
              } catch (e) {
                mensagemSnackBar.erro(context, 'Erro durante o envio do Feedback');
              }
            }
          }
        ), 
      ],
    );
  }
}
