import 'package:agendamentos/constants/Cores.dart';
import 'package:agendamentos/views/AdmHome.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'Perfil.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int paginaAtual = 0;
  PageController pc = PageController();

  //informação deve vir do firebase (services)
  bool isAdm = false;

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
          isAdm ? AdmHome() : Home(),
          Perfil(),
        ],
        onPageChanged: setPagina,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        backgroundColor: Colors.red,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_sharp), label: 'Perfil'),
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
