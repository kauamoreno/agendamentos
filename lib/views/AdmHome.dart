import 'package:agendamentos/constants/Cores.dart';
import 'package:flutter/material.dart';
import 'Perfil.dart';

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
      body: PageView(
        controller: pc,
        children: [
          Container(color: Colors.blue, child: Center(child: Text('Página Home ADM'))),
          Perfil(),
        ],
        onPageChanged: setPagina,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        backgroundColor: Colors.red,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person_2_sharp), label: 'Perfil'),
        ],
        selectedItemColor: Cores.white,
        onTap: (pagina) {
          pc.animateToPage(
            pagina,
            duration: const Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        },
      ),
    );
  }
}
