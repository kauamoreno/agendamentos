import 'package:agendamentos/models/services/Autenticacao.dart';
import 'package:agendamentos/view_model/Agenda/VM_AddAgendamentos.dart';
import 'package:agendamentos/views/components/CustomAppBar.dart';
import 'package:agendamentos/views/constants/Texto.dart';
import 'package:agendamentos/views/components/AgendaWidgets/botao.dart';
import 'package:agendamentos/views/components/inputs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAgendamento extends StatefulWidget {

  final String nomeConjunto;
  final String nomeSala;
  final String dataSelecionada;

  const AddAgendamento({super.key, required this.nomeConjunto, required this.nomeSala, required this.dataSelecionada});

  @override
  State<AddAgendamento> createState() => _AddAgendamentoState();
}

class _AddAgendamentoState extends State<AddAgendamento> {

  DateTime dataSelecionada = DateTime.now();
  late VM_AddAgendamentos vm;
  Autenticacao auth = Autenticacao();

  @override
  void initState() {
    super.initState();
    vm = VM_AddAgendamentos(nomeConjunto: widget.nomeConjunto, nomeSala: widget.nomeSala);
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Formate a string dataSelecionada para DateTime ao inicializar o widget
    dataSelecionada = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(widget.dataSelecionada);
  }

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _notaController = TextEditingController();

  String tempoFinal = "11:30";
  String tempoInicial = "07:30";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titulo: "",
        voltar: true
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),

              Text(
                "Agendamento",
                style: headingStyle,
              ),
              Input(
                titulo: "Titulo *",
                dica: "Digite seu titulo...",
                controller: _tituloController,
              ),
              Input(
                titulo: "Nota",
                dica: "Digite sua nota...",
                controller: _notaController,
              ),
              Input(
                desativado: true,
                titulo: "Data",
                dica: DateFormat('dd/MM/yyyy').format(dataSelecionada), 
                widget: const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                ),
                onTapCallback: () {
                  _pegarDataDoUsuario();                  
                }, 
              ),

              Row(
                children: [
                  Expanded(
                    child: Input(
                      desativado: true,
                      titulo: "Tempo Inicial",
                      dica: tempoInicial,
                      widget: const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.access_time_filled_rounded,
                          color: Colors.grey,
                        ),
                      ),
                      onTapCallback: () {
                        _pegarTempoDoUsuario(oTempoInicial: true);
                      }, 
                    ),
                  ),
                  
                  const SizedBox(width: 12),

                  Expanded(
                    child: Input(
                      desativado: true,
                      titulo: "Tempo Final",
                      dica: tempoFinal,
                      widget: const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.access_time_filled_rounded,
                          color: Colors.grey,
                        ),
                      ),
                      onTapCallback: () {
                        _pegarTempoDoUsuario(oTempoInicial: false);
                      },
                    ),
                  )
                ],
              ),
              
              const SizedBox(height: 30),
              
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 200,
                  child: Botao(
                    label: "Criar",
                    onTap: () async {
                      vm.validaDados(
                        data: DateFormat('dd/MM/yyyy').format(dataSelecionada), 
                        titulo: _tituloController.text,
                        nota: _notaController.text, 
                        timeInicial: tempoInicial, 
                        timeFinal: tempoFinal, 
                        context: context, 
                        nomeProfessor: await auth.getIdNomeProfessorLogado(false) as String, 
                        idProfessor: await auth.getIdNomeProfessorLogado(true) as String
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _pegarDataDoUsuario() async {
    DateTime? pegarData = await showDatePicker(
      context: context,
      initialDate: dataSelecionada,
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
      
    if (pegarData != null) {
      setState(() {
        dataSelecionada = pegarData;
      });
    }
  }

  _pegarTempoDoUsuario({required bool oTempoInicial}) async {
    var pegarTempo = await exibirTempoDoUsuario();
    String tempoFormatado = pegarTempo.format(context);
    
    if (oTempoInicial == true) {
      setState(() {
        tempoInicial = tempoFormatado;
      });
    } else if (oTempoInicial == false) {
      setState(() {
        tempoFinal = tempoFormatado;
      });
    }
  }

  exibirTempoDoUsuario() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(tempoInicial.split(":")[0]),
        minute: int.parse(tempoInicial.split(":")[1].split(" ")[0])
      )
    );
  }

}
