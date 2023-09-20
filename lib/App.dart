import 'package:agendamentos/views/pages/Erros/ErrorPage.dart';
import 'package:agendamentos/views/pages/GerenciarSalas.dart';
import 'package:agendamentos/views/pages/GerenciarUser.dart';
import 'package:agendamentos/views/pages/Home/AdmHome.dart';
import 'package:agendamentos/views/pages/Home/UserHome.dart';
import 'package:agendamentos/views/pages/Sala/SalasConjunto.dart';
import 'package:agendamentos/views/pages/TelaLogin.dart';
import 'package:agendamentos/views/pages/Agenda/AddAgendamento.dart';
import 'package:agendamentos/views/pages/TelaSalas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './views/pages/Relatorios.dart';
import 'views/pages/Agenda/Calendario.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    //Para sempre ficar em vertical o app, nao permitir rolagem
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.red
      ),

      initialRoute: '/',
      routes:{
        '/': (context) => TelaLogin(),
        '/userHome':(context) => const UserHome(),
        '/admHome':(context) => const AdmHome(),
        '/relatorio': (context) => RelatoriosPage(),
        '/gerenciarProfessores': (context) => const GerenciarProf(),
        '/gerenciarSalas': (context) => const GerenciaSala(),
        '/calendario': (context) => const Calendario(),
        '/agendamento': (context) => const AddAgendamento(),
        '/salasConjunto': (context) => const SalasConjunto(),
        '/salas': (context) => const TelaSalas(),
        '/erro': (context) { 
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is bool) {
            return ErrorPage(erroMensagem: args);
          }

          return const ErrorPage(erroMensagem: 'Error');
        }
      },
    );
  }
}
