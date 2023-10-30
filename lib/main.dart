import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'App.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    // Login persistente
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  } catch (e) {
    //Se entrar aqui, indica que o app foi executado no celular, e não na Web
  }

  runApp(const App());
}
