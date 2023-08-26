import 'package:agendamentos/views/pages/TelaLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'views/pages/Home/UserHome.dart';
import 'views/pages/Perfil.dart';
import 'views/pages/AdmHome.dart';

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

      initialRoute: '/',
      routes:{
        '/':(context) => TelaLogin(),
        '/home':(context) => Home(),
        '/admHome':(context) => AdmHome(),
        '/perfil':(context) => Perfil()
      },
    );
  }
}