import 'dart:html';
import 'package:agendamentos/views/components/CustomAppBar.dart';
import 'package:agendamentos/views/constants/Temas.dart';
import 'package:agendamentos/views/components/widgets_calendario/add_agenda_bar.dart';
import 'package:agendamentos/views/components/widgets_calendario/botao.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeCalendar extends StatefulWidget {
  const HomeCalendar({super.key});

  @override
  State<HomeCalendar> createState() => _HomeCalendarState();
}

class _HomeCalendarState extends State<HomeCalendar> {
  DateTime _dataSelecionanda = DateTime.now();
  var notificacao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titulo: "Calendario"),
      backgroundColor: context.theme.backgroundColor,
      body: Column(children: [
        addAgendamento(),
        addDataBar(), //BOTAO DOS AGENDAMENTO SENDO CHAMADO AQUI,
        SizedBox(
          height: 10,
        ),
      ]),
    );
  }

  botoesCancelareCompletar(
      {required String label,
      required Function()? onTap,
      required Color clr,
      bool fechar = false,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        color: fechar == true ? Colors.red : clr,
        decoration: BoxDecoration(
            //PAREI AQUI 45:00
            ),
      ),
    );
  }

  addDataBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        //USADO PARA CHAMAR UMA LISTA COM VARIAS DATAS
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Color.fromARGB(255, 78, 81, 247),
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        )),
        dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        )),
        monthTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        )),
        onDateChange: (data) {
          _dataSelecionanda = data;
        },
      ),
    );
  }

  addAgendamento() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  "Hoje",
                  style: headingStyle,
                ),
              ],
            ),
          ),
          Botao(
              label: "+Add Ag",
              onTap: () async {
                await Get.to(() => addAgendametoPagina());
              }) //BOTAO PARA FAZER O LIGAMENTO ENTRE A PAGINA HOME E AGENDAMENTO
        ],
      ),
    );
  }
}
