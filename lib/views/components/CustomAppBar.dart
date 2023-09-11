import 'package:agendamentos/view_model/SnackBarViewModel.dart';
import 'package:flutter/material.dart';
import '../../models/services/Firestore/Feedback.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String titulo;
  final bool voltar;

  const CustomAppBar({super.key, required this.titulo, this.voltar = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titulo),
      automaticallyImplyLeading: voltar,
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
          onPressed: () {
            FeedbackService().enviarFeedback(key: _formKey, controller: _controller, context: context);
          }
        ), 
      ],
    );
  }
}
