import 'package:agendamentos/views/pages/Relatorios.dart';
import 'package:flutter/material.dart';

class Routes{
  static Map<String, Widget Function(BuildContext)> list = <String, WidgetBuilder>{
    '/relatorios': (context) => RelatoriosPage()
  };


   static GlobalKey<NavigatorState>? navegadorChave = GlobalKey<NavigatorState>();
}