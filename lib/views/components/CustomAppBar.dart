import 'package:agendamentos/view_model/SnackBarViewModel.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/services/Firestore/Feedback.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
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
          onPressed: (){
            _launchUrl();
          },
          icon: Icon(Icons.help_outline)
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

final Uri _url = Uri.parse('https://tasteful-orca-fad.notion.site/Manual-de-Usu-rio-AGS-42963e08e8624e069340f2a9ca30a6be'); //Manual do usuario
Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
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
              FeedbackService().enviarFeedback(
                  key: _formKey, controller: _controller, context: context);
            }),
      ],
    );
  }
}
