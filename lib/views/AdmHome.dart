import 'package:agendamentos/constants/Cores.dart';
import 'package:flutter/material.dart';

class AdmHome extends StatefulWidget {
  const AdmHome({Key? key}) : super(key: key);

  @override
  State<AdmHome> createState() => _AdmHomeState();
}

class _AdmHomeState extends State<AdmHome> {
  int paginaAtual = 0;
  PageController pc = PageController();

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPagina(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home ADM"),
        automaticallyImplyLeading:
            false, //USADO PARA REMOVER A SETINHA DO APPBAR
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Container(color: Colors.blue, child: Center(child: Text('Página Home ADM')))
      ),
    );
  }
}
