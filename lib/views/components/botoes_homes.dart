import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'CustomAppBar.dart';

BotoesHome(BuildContext context, String text, IconData icon, Color color, String route, [String? args]) {
  return GestureDetector(
    onTap: () async{
      if (route == '/feedback') {
        showDialog(context: context, builder: (context) => DialogoAlerta());
      } else if(route == '/noticias'){
        _launchUrl();
      } else {
        Navigator.pushNamed(context, route);
      }
    },
    child: Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 48.0,
            color: Colors.white,
          ),
          SizedBox(height: 10.0),
          Text(
            text,
            style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    ),
  );
}

final Uri _url = Uri.parse('https://sp.senai.br/noticias');
Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}