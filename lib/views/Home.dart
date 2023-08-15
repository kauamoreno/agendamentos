import 'dart:html';
import 'package:flutter/material.dart';
import '../App.dart';
import 'Perfil.dart';
import '../components/MensagemSnackBar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageSelecionada = 0;

  void itemSelecionado(int index) {
    setState(() {
      pageSelecionada = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),

      //NAVIGATION BAR
      body: Column(
        children: [
          ElevatedButton(onPressed: () {
             MensagemSnackBar mensagemSnackBar = MensagemSnackBar();
             mensagemSnackBar.showErro(context, 'Errou');
        }, child: Text("Teste"))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_3_sharp), label: "Perfil")
        ],
        selectedItemColor: Colors.white,
        currentIndex: pageSelecionada,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/perfil');
              break;
          }
        },
      ),
    );
  }
}
