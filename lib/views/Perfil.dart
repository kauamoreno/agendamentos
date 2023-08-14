import 'package:flutter/material.dart';
import 'Home.dart';
import '../App.dart';

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  int pageSelecionada = 0;
  late PageController animationPage;

  void itemSelecionado(int index) {
    setState(() {
      pageSelecionada = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil do Usuario"),
      ),
      //NAVIGATION BAR
      body: Column(
        children: <Widget>[],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_3_outlined), label: "Perfil")
        ],
        selectedItemColor: Colors.white,
        currentIndex: pageSelecionada,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/perfil');
              break;
          }
        },
      ),
    );
  }
}
