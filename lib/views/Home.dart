import 'dart:html';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text("Home"),
      ),
      
       //NAVIGATION BAR
      body: Column(
        children: <Widget> [],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_3_sharp),
            label: "Perfil"
          )
        ],
        selectedItemColor: Colors.white
      ),
    );
  }
}