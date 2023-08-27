import 'package:agendamentos/view_model/NavBar_ViewModel.dart';
import '../constants/Cores.dart';
import 'package:flutter/material.dart';
import 'Perfil.dart';

class Navbar extends StatefulWidget {
  final bool isAdm;
  const Navbar({Key? key, required this.isAdm}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  
  late final NavbarViewModel viewModel;
  int paginaAtual = 0;
  PageController pc = PageController();
  
  @override
  void initState() {
    super.initState();
    viewModel = NavbarViewModel(isAdm: widget.isAdm);
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
        onPageChanged: setPagina,
        children: [
          viewModel.escolheTelaHome(),
          const Perfil()
        ],
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