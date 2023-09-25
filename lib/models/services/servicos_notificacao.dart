import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificacaoCustomizada{
  final int id; //id da mensagem exibida
  final String? title; //titulo da mensagem
  final String? body; // mensagem que quiser exibir
  final String? payload; // caso houver necessidade de mandar outros tipos de dados, a rota que vai ser acessada pelo usuario vai ser tambem pelo payload, ao ser clicada

  NotificacaoCustomizada({required this.id, required ,required this.title,required this.body,required this.payload});
}

class NotificacaoEservicos{
  late FlutterLocalNotificationsPlugin localNotificationsPlugin; //inicialização tardia, volta um mesmo valor sempre
  late AndroidNotificationDetails androidDetalhes; // detalhes de notificação para o android
  
  NotificacaoEservicos(){
    localNotificationsPlugin = FlutterLocalNotificationsPlugin(); //instancia para acessar os dados locais do sistema operacional 
    _setupNotificacoes();
  }

  _setupNotificacoes() async{
    await _setupTimezone();
    await _iniciarNotificacao(); 
  }  

  Future<void> _setupTimezone() async{
    tz.initializeTimeZones(); //lista internacional de timezones
    final String? timezone = await FlutterNativeTimezone.getLocalTimezone(); //neste trecho vamos pegar o timeZone do sistema operacional que esta setado
    tz.setLocalLocation(tz.getLocation(timezone!));
  }

  //configuração especifica de cada sistema operacional, IOS ou Android
  _iniciarNotificacao() async{
    //aqui personalizamos o tipo de icone que irá ser exibido nas notificações
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    //abaixo iremos passar as configurações para cada sistema 
    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
      //onDidReceiveNotificationResponse:_onNotificacaoSelecionada,
    );
  }

  _onNotificacaoSelecionada(String? payload){
    if(payload != null && payload.isNotEmpty){
     // Navigator.of(Routes.navigatorKey!.currentContext).pushReplacementNamed('');
    }
  }

}

//https://www.youtube.com/watch?v=ilm89PL6-K8&t=359s => 13:40
