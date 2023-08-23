import 'package:flutter/material.dart';
import '../components/TextFieldComponent.dart';
import '../components/CardsComponent.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageSelecionada = 0;

  TextFieldComponent textFieldComponent = TextFieldComponent();
  final _pesquisaController = TextEditingController();
  
  CardsComponent cardsComponent = CardsComponent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        automaticallyImplyLeading:
            false, //USADO PARA REMOVER A SETINHA DO APPBAR
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            textFieldComponent.textFieldPesquisa(label: "Pesquisa", hint: 'Pesquisa...', controller: _pesquisaController),
            Expanded(
              child: SingleChildScrollView(
              child: Column(
                children: [
                  cardsComponent.CardFiltroSalas(tipoSala: "Salas de Aula", disponivel: 5, icone: Icons.class_),
                  cardsComponent.CardFiltroSalas(tipoSala: "Salas de Informática", disponivel: 1, icone: Icons.computer),
                  cardsComponent.CardFiltroSalas(tipoSala: "Salas de Elétrica", disponivel: 3, icone: Icons.bolt),
                  cardsComponent.CardFiltroSalas(tipoSala: "Espaços Grandes", disponivel: 2, icone: Icons.landscape),
                  cardsComponent.CardFiltroSalas(tipoSala: "Espaços Grandes", disponivel: 3, icone: Icons.landscape),
                ],
              ),
            )
            )
          ],
        ),
      )
    );
  }
}