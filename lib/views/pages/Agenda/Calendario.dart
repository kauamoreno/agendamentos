import 'package:agendamentos/view_model/Agenda/VM_Calendario.dart';
import 'package:agendamentos/views/components/CustomAppBar.dart';
import 'package:agendamentos/views/constants/Texto.dart';
import 'package:agendamentos/views/components/AgendaWidgets/botao.dart';
import 'package:agendamentos/views/pages/Erros/ErrorPage.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Calendario extends StatefulWidget {
  
  final String nomeConjunto;
  final String nomeSala;

  const Calendario({super.key, required this.nomeConjunto, required this.nomeSala});

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {

  DateTime _dataSelecionanda = DateTime.now();
  late String notificacao;
  late VM_Calendario vm;

  @override
  void initState() {
    super.initState();
    vm = VM_Calendario(nomeConjunto: widget.nomeConjunto, nomeSala: widget.nomeSala);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titulo: "Calendário", voltar: true,),
      body: Column(
        children: [
          addAgendamento(),
          addDataBar(),
          const SizedBox(height: 10),

          Expanded(
            child: FutureBuilder(
              future: vm.getAgendamentos(context, _dataSelecionanda), 
              builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());

                } else if (snapshot.hasError) {
                  return ErrorPage(erroMensagem: snapshot.error);

                } else {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 30), //Espaço

                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: snapshot.data ?? [], // Lista de widgets de cards.
                            ),
                          )
                        )
                      ],
                    ),
                  );
                }
              },
            )
          )

        ]
      ),
    );
  }

  botoesCancelareCompletar({
    required String label,
    required Function()? onTap,
    required Color clr,
    required BuildContext context,
    bool fechar = false
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        color: fechar == true ? Colors.red : clr,
      ),
    );
  }

  addDataBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),

      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor:const Color.fromARGB(255, 78, 81, 247),
        selectedTextColor: Colors.white,

        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          )
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          )
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          )
        ),
        onDateChange: (data) {
          setState(() {
            _dataSelecionanda = data;
          });
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
            width: MediaQuery.of(context).size.width * 0.5,
            margin: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd('pt_BR').format(DateTime.now()),
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
            label: " Agendar ",
            onTap: () {
              Navigator.pushNamed(context, '/agendamento', arguments: {
                'nomeConjunto': widget.nomeConjunto, 
                'nomeSala': widget.nomeSala,
                'dataSelecionada': _dataSelecionanda.toString()
              });
            }
          )
        ],
      ),
    );
  }
}
