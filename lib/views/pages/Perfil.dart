import 'package:agendamentos/views/components/CustomAppBar.dart';
import 'package:agendamentos/views/components/SalasCard.dart';
import 'package:flutter/material.dart';

import '../components/Texto.dart';
import '../constants/Cores.dart';

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  SalasCard salasCard = SalasCard();
  String nome = "Carlinhos";
  String cargo = "Instrutor";
  String escola = "Senai - Nami Jafet 117";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titulo: 'Perfil'),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // BARRA DO PERFIL
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)
              )
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    'https://www.offidocs.com/images/xtwitterdefaultpfpicon.jpg.pagespeed.ic.9q2wXBQmsW.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                ElementoTexto().escreverTexto(
                  texto: '$nome\n$cargo\n$escola',
                  tamanho: 20,
                  corFonte: Cores.white,
                  expessura: FontWeight.w500
                )
              ],
            ),
          ),

          // CARD "MINHAS AGENDAS"
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Cores.fundoCard,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.schedule_rounded,
                    color: Cores.letraCard,
                    size: 64,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: ElementoTexto().escreverTexto(
                      texto: 'Minhas Agendas',
                      alinhamento: TextAlign.center,
                      fonte: 'Readex Pro',
                      tamanho: 28,
                      expessura: FontWeight.w500,
                      corFonte: Cores.letraCard
                    )
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  salasCard.salaConjunto(
                    context: context,
                    titulo: "Sala 7:",
                    subTitulo: "Segunda-Feira\n7h30 - 11h30",
                    imgUrl:
                    'https://www.visitdubai.com/-/media/gathercontent/article/t/top-rides-at-img-worlds-of-adventure/media/top-rides-at-img-worlds-of-adventure-predator-5.jpg?&cw=256&ch=256'
                  ),
                  salasCard.salaConjunto(
                    context: context,
                    titulo: "Sala 3:",
                    subTitulo: "Terça-Feira\n12h30 - 16h30",
                    imgUrl:
                    'https://www.visitdubai.com/-/media/gathercontent/article/t/top-rides-at-img-worlds-of-adventure/media/top-rides-at-img-worlds-of-adventure-predator-5.jpg?&cw=256&ch=256'
                  ),
                  salasCard.salaConjunto(
                    context: context,
                    titulo: "Sala 4:",
                    subTitulo: "Terça-Feira\n12h30 - 16h30",
                    imgUrl:
                    'https://www.visitdubai.com/-/media/gathercontent/article/t/top-rides-at-img-worlds-of-adventure/media/top-rides-at-img-worlds-of-adventure-predator-5.jpg?&cw=256&ch=256'
                  )
                ]
              ),
            ),
          ),
        ],
      )
    );
  }
}
