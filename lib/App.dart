import 'package:agendamentos/views/TelaLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'views/Home.dart';
import 'views/NavBar.dart';
import './views/Perfil.dart';
import './views/AdmHome.dart';

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

      initialRoute: '/home',
      routes:{
        '/':(context) => TelaLogin(),
        '/home':(context) => Navbar(),
      },
    );
  }
}