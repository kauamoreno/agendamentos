import 'package:agendamentos/views/pages/TelaLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './views/pages/NavBar.dart';
import './views/pages/Erros/ErrorPage.dart';

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
        '/': (context) => TelaLogin(),
        '/home': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is bool) {
            return Navbar(isAdm: args);
          }
          
          return const ErrorPage(
            erroMensagem: 'Desculpe, mas parece que houve um problema ao tentar exibir a página inicial. Por favor, tente novamente',
          );
        },
      },
    );
  }
}