import 'dart:html';
// import 'package:calendar/controles/task.controle.dart';
import 'package:agendamentos/views/pages/Temas.dart';
import 'package:agendamentos/views/pages/widgets/add_agenda_bar.dart';
import 'package:agendamentos/views/pages/widgets/botao.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
// import 'package:calendar/servicos/servicosTemas.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

class HomeCalendar extends StatefulWidget {
  const HomeCalendar({super.key});

  @override
  State<HomeCalendar> createState() => _HomeCalendarState();
}

class _HomeCalendarState extends State<HomeCalendar> {
  DateTime _dataSelecionanda = DateTime.now();
  var notificacao;
  // final taskControler = Get.put(TaskControle());

  // @override
  // void initState() {
  //   super.initState();
  //   notificacao = Notificacoes();
  //   notificacao.requestIOSPermissions();
  //   notificacao.initializeNotification();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(children: [
        addAgendamento(),
        addDataBar(), //BOTAO DOS AGENDAMENTO SENDO CHAMADO AQUI,
        SizedBox(
          height: 10,
        ),
        // mostrarTasks(),
      ]),
    );
  }

  // mostrarTasks() {
  //   return Container(
  //     child: Expanded(
  //       flex: 1,
  //       child: Obx(() {
  //         return ListView.builder(
  //             itemCount: taskControler.taskLista.length,
  //             itemBuilder: (_, index) {
  //               print(taskControler.taskLista.length);

  //               return AnimationConfiguration.staggeredList(
  //                   position: index,
  //                   child: SlideAnimation(
  //                     child: FadeInAnimation(
  //                       child: Row(
  //                         children: [
  //                           GestureDetector(
  //                             onTap: () {},
  //                             child: TaskTile(taskControler.taskLista[index]),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ));
  //             });
  //       }),
  //     ),
  //   );
  // }

  // _mostrarBotoesCancelareCompletar(BuildContext context, Task task) {
  //   Get.bottomSheet(Container(
  //     padding: const EdgeInsets.only(top: 4),
  //     height: task.estaCompleto == 1
  //         ? MediaQuery.of(context).size.height * 0.24
  //         : MediaQuery.of(context).size.height * 0.32,
  //     color: Get.isDarkMode ? cinzaEscuroClr : Colors.white,
  //     child: Column(
  //       children: [
  //         Container(
  //           height: 6,
  //           width: 120,
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(10),
  //               color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
  //         ),
  //         task.estaCompleto == 1
  //             ? Container()
  //             : botoesCancelareCompletar(
  //                 label: "Agendamento Completo",
  //                 onTap: () {
  //                   Get.back();
  //                 },
  //                 clr: primaryClr,
  //                 context: context)
  //       ],
  //     ),
  //   ));
  // }

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
        selectionColor: primaryClr,
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
                // Text(
                //   //DateFormat.yMMMMd().format(DateTime.now()),
                //  // style: subHeadingStyle,
                // ),
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
                // await Get.to(() => addAgendametoPagina());
                // taskControler.getTasks();
              }) //BOTAO PARA FAZER O LIGAMENTO ENTRE A PAGINA HOME E AGENDAMENTO
        ],
      ),
    );
  }

  _AppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          // temasServicos().trocarTema();
          notificacao.displayNotification(
              Title: "TEMA TROCADO",
              body:
                  Get.isDarkMode ? "ATIVADO MODO DARK" : "ATIVADO MODO CLARO");
        },
        child: Icon(Icons.nightlight_round,
            size: 20, color: Get.isDarkMode ? Colors.white : Colors.black),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage("images/perfil.png"),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
