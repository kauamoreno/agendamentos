import 'package:agendamentos/views/TelaLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'views/TelaLogin.dart'; 
import './views/Home.dart';
import './views/Perfil.dart';
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    //Para sempre ficar em vertical o app, nao permitir rolagem
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      //INICIANDO ROTAS 
      routes:{
        '/':(context) => TelaLogin(), //TELA PRINCIPAL
        '/home':(context) => Home(),
        '/perfil':(context) => Perfil()
      },
    );
  }
}