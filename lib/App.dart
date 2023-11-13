import 'package:agendamentos/views/pages/Agenda/MinhasAgendas.dart';
import 'package:agendamentos/views/pages/Erros/ErrorPage.dart';
import 'package:agendamentos/views/pages/Adm/Gerenciar/GerenciarConjunto.dart';
import 'package:agendamentos/views/pages/Adm/Gerenciar/GerenciarSalas.dart';
import 'package:agendamentos/views/pages/Adm/Gerenciar/GerenciarUser.dart';
import 'package:agendamentos/views/pages/Adm/AdmHome.dart';
import 'package:agendamentos/views/pages/Usuarios/UserHome.dart';
import 'package:agendamentos/views/pages/Sala/SalasConjunto.dart';
import 'package:agendamentos/views/pages/TelaLogin.dart';
import 'package:agendamentos/views/pages/Agenda/AddAgendamento.dart';
import 'package:agendamentos/views/pages/Sala/TelaSalas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'views/pages/Adm/Relatorios.dart';
import 'views/pages/Agenda/Calendario.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    //Para sempre ficar em vertical o app, nao permitir rolagem
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'), 
      ],
      locale: const Locale('pt'),

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
        '/gerenciarConjunto': (context) => const GerenciaConjunto(),
        '/salasConjunto': (context) => const SalasConjunto(),

        '/minhasAgendas': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if(args is String) {
            return MinhasAgendas(idProfessor: args);
          }
          return MinhasAgendas(idProfessor: '');
        }, 

        '/calendario': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is Map<String, String>) {
            final nomeConjunto = args['nomeConjunto'];
            final nomeSala = args['nomeSala'];
            if (nomeConjunto != null && nomeSala != null) {
              return Calendario(nomeConjunto: nomeConjunto, nomeSala: nomeSala);
            }
          }
          return const ErrorPage(erroMensagem: 'Error');
        },

        '/agendamento': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is Map<String, String>) {
            final nomeConjunto = args['nomeConjunto'];
            final nomeSala = args['nomeSala'];
            final dataSelecionada = args['dataSelecionada'];
            if (nomeConjunto != null && nomeSala != null && dataSelecionada != null) {
              return AddAgendamento(nomeConjunto: nomeConjunto, nomeSala: nomeSala, dataSelecionada: dataSelecionada);
            }
          }
          return const ErrorPage(erroMensagem: 'Error');
        },

        '/gerenciarSalas': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if(args is String) {
            return GerenciaSala(nomeConjunto: args);
          }
          return const ErrorPage(erroMensagem: 'Error'); 
        },

        '/salas': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if(args is String) {
            return TelaSalas(nomeConjunto: args);
          }
          return const ErrorPage(erroMensagem: 'Error');
        }, 

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
