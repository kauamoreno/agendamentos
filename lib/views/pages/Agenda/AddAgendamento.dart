import 'package:agendamentos/models/services/Autenticacao.dart';
import 'package:agendamentos/view_model/Agenda/VM_AddAgendamentos.dart';
import 'package:agendamentos/views/components/CustomAppBar.dart';
import 'package:agendamentos/views/constants/Texto.dart';
import 'package:agendamentos/views/components/AgendaWidgets/botao.dart';
import 'package:agendamentos/views/components/AgendaWidgets/inputs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAgendamento extends StatefulWidget {

  final String nomeConjunto;
  final String nomeSala;

  const AddAgendamento({super.key, required this.nomeConjunto, required this.nomeSala});

  @override
  State<AddAgendamento> createState() => _AddAgendamentoState();
}

class _AddAgendamentoState extends State<AddAgendamento> {

  late VM_AddAgendamentos vm;
  Autenticacao auth = Autenticacao();

  @override
  void initState() {
    super.initState();
    vm = VM_AddAgendamentos(nomeConjunto: widget.nomeConjunto, nomeSala: widget.nomeSala);
  }

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _notaController = TextEditingController();

  DateTime dataSelecionada = DateTime.now();
  String tempoFinal = "11:30";
  String tempoInicial = DateFormat("hh:mm").format(DateTime.now()).toString();
  
  int _lembreteSelecionado = 5;
  List<int> listaLembrete = [
    5,
    10,
    15,
    20,
  ];

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
              InputAgendamentos(
                titulo: "Titulo",
                dica: "Digite seu titulo...",
                controller: _tituloController, 
                desativado: false,
              ),
              InputAgendamentos(
                titulo: "Nota",
                dica: "Digite sua nota...",
                controller: _notaController, 
                desativado: false,
              ),
              InputAgendamentos(
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
                    child: InputAgendamentos(
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
                    child: InputAgendamentos(
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

              InputAgendamentos(
                desativado: true,
                titulo: "Lembrete",
                dica: "$_lembreteSelecionado minutos restantes",
                widget: Expanded(
                  child: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                
                    iconSize: 32,
                    elevation: 4,
                    style: subTituloStyle,
                    underline: Container(
                      height: 0,
                    ),
                    onChanged: (String? novoValor) {
                      setState(() {
                        _lembreteSelecionado = int.parse(novoValor!);
                      });
                    },
                      
                    items: listaLembrete.map<DropdownMenuItem<String>>((int valor) {
                      return DropdownMenuItem<String>(
                        value: valor.toString(),
                        child: Text(valor.toString()),
                      );
                    }).toList(),
                  ),
                ),
              ),
              
              const SizedBox(height: 18),
              
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 200,
                  child: Botao(
                    label: "Criar",
                    onTap: () async {
                      vm.validaDados(
                        titulo: _tituloController.text, 
                        data: DateFormat('dd/MM/yyyy').format(dataSelecionada), 
                        nota: _notaController.text, 
                        timeInicial: tempoInicial, 
                        timeFinal: tempoFinal, 
                        lembrete: '', 
                        context: context, 
                        nomeProfessor: await auth.getNomeProfessorLogado() as String
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
      initialDate: DateTime.now(),
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
