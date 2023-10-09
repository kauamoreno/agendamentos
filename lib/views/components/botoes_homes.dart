import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'CustomAppBar.dart';

BotoesHome(BuildContext context, String text, IconData icon, Color color,
    String route) {
  return GestureDetector(
      onTap: () async {
        if (route == '/feedback') {
          showDialog(context: context, builder: (context) => DialogoAlerta());
        } else if (route == '/noticias') {
          _launchUrl();
        } else if (route == '/escolhaDeGerenciamento') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.8,
                  child: AlertDialog(
                    title: Text('Gerenciar:'),
                    content: Row(
                      children: [
                        BotoesHome(
                            context,
                            ' Professores ',
                            Icons.settings,
                            Color.fromARGB(255, 233, 226, 226),
                            '/gerenciarProfessores'),
                        BotoesHome(
                            context,
                            '        Salas        ',
                            Icons.settings,
                            Color.fromARGB(255, 233, 226, 226),
                            '/gerenciarSalas'),
                        // Adicione mais botões personalizados conforme necessário
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Fechar'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          Navigator.pushNamed(context, route);
        }
      },
      child: Container(
        margin: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white, // Fundo branco
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 3), // deslocamento do sombramento
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100, // Largura do botão
              height: 100, // Altura do botão
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red, // Cor do círculo
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 48.0,
                  color: Colors.white, // Cor do ícone
                ),
              ),
            ),
            SizedBox(height: 10.0), // Espaçamento entre o círculo e o texto
            Text(
              text,
              style: TextStyle(
                color: Colors.black, // Cor do texto
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ));
}

final Uri _url = Uri.parse('https://sp.senai.br/noticias');
Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
