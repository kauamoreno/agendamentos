import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageSelecionada = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        automaticallyImplyLeading:
            false, //USADO PARA REMOVER A SETINHA DO APPBAR
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Container(color: Colors.blue, child: Center(child: Text('Página Home Usuário')))
      ),
    );
  }
}
