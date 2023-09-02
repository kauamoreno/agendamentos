import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../view_model/SnackBarViewModel.dart';

class FeedbackService {

  SnackBarViewModel mensagemSnackBar = SnackBarViewModel();

  enviarFeedback ({
    required GlobalKey<FormState> key,
    required TextEditingController controller,
    required BuildContext context
  }) async {

    if (key.currentState!.validate()) {

      try {
        final collection = FirebaseFirestore.instance.collection('feedback');

        await collection.doc().set({
          'timestamp': FieldValue.serverTimestamp(),
          'feedback': controller.text,
        });

        mensagemSnackBar.sucesso(context, 'Feedback enviado');
        Navigator.pop(context);

      } catch (e) {

        mensagemSnackBar.erro(context, 'Erro durante o envio do Feedback');

      }

    }
  }
}