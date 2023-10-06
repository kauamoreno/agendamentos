import 'package:flutter/material.dart';
import 'dart:core'; 
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ErrorPage extends StatefulWidget {

  final erroMensagem;
  const ErrorPage({
    super.key, 
    required this.erroMensagem
  });

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  final emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'kaua.moreno2005@gmail.com',
    queryParameters: <String, String>{ 
      'subject': 'Relatando erro no aplicativo',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Erro'),
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(20,20,20,20),
        child: Column(
          children: [

            const SizedBox(height: 40), //Espaço
            const Text(
              'Ops! Algo deu errado :/',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
              ),
            ),

            const SizedBox(height: 40), //Espaço
            SingleChildScrollView(
              child: AutoSizeText(
                widget.erroMensagem,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 20,
                ),
                minFontSize: 14,
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const Spacer(),

            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(const Size(350, 60)), 
              ),
              child: const Text('Voltar'),
              
              onPressed: () => { 
                Navigator.pop(context)
              },
            ),

            const SizedBox(height: 20), //Espaço

            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(const Size(350, 60)),  
              ),
              child: const Text('Relatar Problema'),

              onPressed: () => { 
                launchUrl(emailLaunchUri)
              },
            ),
                
            const SizedBox(height: 100), //Espaço
            
          ],
        ),
      )
    );
  }
}