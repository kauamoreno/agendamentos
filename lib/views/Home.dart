import 'package:flutter/material.dart';

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
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/perfil');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        automaticallyImplyLeading: false, //USADO PARA REMOVER A SETINHA DO APPBAR
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        currentIndex: pageSelecionada,
        onTap: itemSelecionado,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person_3_sharp), label: "Perfil")
        ],
        selectedItemColor: Colors.white,
      ),
    );
  }
}
