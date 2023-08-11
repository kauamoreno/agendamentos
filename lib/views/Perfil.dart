import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  const Perfil({ Key? key }) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil do Usuario"),
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
            label: "Home",
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_3_outlined),
            label: "Perfil"
          )
        ],
        selectedItemColor: Colors.white
      ),
    );
  }
}