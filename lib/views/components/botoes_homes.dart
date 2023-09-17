import 'package:flutter/material.dart';
import 'CustomAppBar.dart';

BotoesHome(BuildContext context, String text, IconData icon, Color color,
    String route) {
  return GestureDetector(
    onTap: () {
      if (route == '/feedback') {
        showDialog(context: context, builder: (context) => DialogoAlerta());
      } else {
        Navigator.pushNamed(context, route);
      }
    },
    child: Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
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
