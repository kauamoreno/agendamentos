import 'package:agendamentos/views/components/SalasCard.dart';
import 'package:flutter/material.dart';

import '../../components/TextFieldComponent.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  TextFieldComponent textFieldComponent = TextFieldComponent();
  final _pesquisaController = TextEditingController();
  
  SalasCard salasCard = SalasCard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        automaticallyImplyLeading:
            false, //USADO PARA REMOVER A SETINHA DO APPBAR
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
        child: Column(
          children: [
            textFieldComponent.textFieldPesquisa(label: "Pesquisa", hint: 'Pesquisa...', controller: _pesquisaController),
            Expanded(
              child: SingleChildScrollView(
              child: Column(
                children: [
                  salasCard.salaConjunto(context: context, titulo: 'Salas de Aula', subTitulo: '(5 disponíveis)', imgUrl: 'https://www.visitdubai.com/-/media/gathercontent/article/t/top-rides-at-img-worlds-of-adventure/media/top-rides-at-img-worlds-of-adventure-predator-5.jpg?&cw=256&ch=256'),
                  salasCard.salaConjunto(context: context, titulo: 'Salas de informática', subTitulo: '(1 disponível)', imgUrl: 'https://www.visitdubai.com/-/media/gathercontent/article/t/top-rides-at-img-worlds-of-adventure/media/top-rides-at-img-worlds-of-adventure-predator-5.jpg?&cw=256&ch=256'),
                  salasCard.salaConjunto(context: context, titulo: 'Salas de Elétrica', subTitulo: '(2 disponíveis)', imgUrl: 'https://www.visitdubai.com/-/media/gathercontent/article/t/top-rides-at-img-worlds-of-adventure/media/top-rides-at-img-worlds-of-adventure-predator-5.jpg?&cw=256&ch=256'),
                  salasCard.salaConjunto(context: context, titulo: 'Salas de Mecânica', subTitulo: '(1 disponível)', imgUrl: 'https://www.visitdubai.com/-/media/gathercontent/article/t/top-rides-at-img-worlds-of-adventure/media/top-rides-at-img-worlds-of-adventure-predator-5.jpg?&cw=256&ch=256'),
                  salasCard.salaConjunto(context: context, titulo: 'Espaços Grandes', subTitulo: '(2 disponíveis)', imgUrl: 'https://www.visitdubai.com/-/media/gathercontent/article/t/top-rides-at-img-worlds-of-adventure/media/top-rides-at-img-worlds-of-adventure-predator-5.jpg?&cw=256&ch=256')
                  
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
