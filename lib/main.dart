import 'dart:js';

import 'package:agendamentos/models/services/servicos_notificacao.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
// import 'firebase_options.dart';
import 'App.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(
      //permite o serviço de notificaçõa em qualquer parte do aplicativo
      MultiProvider(
    providers: [
      Provider<NotificacaoEservicos>(
          create: (context) => NotificacaoEservicos()),
    ],
    child: const App(),
  ));
}
