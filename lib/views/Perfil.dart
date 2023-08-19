import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
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
        title: Text("Perfil do Usuario"),
        automaticallyImplyLeading: false, //USADO PARA REMOVER A SETINHA DO APPBAR
      ),

      body: Column(
        children: <Widget>[],
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        currentIndex: pageSelecionada,
        onTap: itemSelecionado,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_3_sharp), label: "Perfil")
        ],
        selectedItemColor: Colors.white,
      ),
    );
  }
}
