import 'package:agendamentos/view_model/VM_AddAgendamentos.dart';
import 'package:agendamentos/views/components/CustomAppBar.dart';
import 'package:agendamentos/views/constants/Texto.dart';
import 'package:agendamentos/views/components/AgendaWidgets/botao.dart';
import 'package:agendamentos/views/components/AgendaWidgets/inputs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAgendamento extends StatefulWidget {
  const AddAgendamento({super.key});

  @override
  State<AddAgendamento> createState() => _AddAgendamentoState();
}

class _AddAgendamentoState extends State<AddAgendamento> {

  VM_AddAgendamentos vm = VM_AddAgendamentos();

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _notaController = TextEditingController();

  DateTime dataSelecionada = DateTime.now();
  String tempoFinal = "00:00";
  String tempoInicial = DateFormat("hh:mm a").format(DateTime.now()).toString();
  
  int _lenbreteSelecionado = 5;
  List<int> listaLembrete = [
    5,
    10,
    15,
    20,
  ];

  int _corSelecionada = 0;

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
                "Add Agendamento",
                style: headingStyle,
              ),
              InputAgendamentos(
                titulo: "Titulo",
                dica: "Digite seu titulo...",
                controller: _tituloController,
              ),
              InputAgendamentos(
                titulo: "Nota",
                dica: "Digite sua nota...",
                controller: _notaController,
              ),
              InputAgendamentos(
                titulo: "Data",
                dica: DateFormat('dd/MM/yyyy').format(dataSelecionada),
                widget: IconButton(
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _pegarDataDoUsuario();
                    });
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputAgendamentos(
                      titulo: "Tempo Inicial",
                      dica: tempoInicial,
                      widget: IconButton(
                        onPressed: () {
                          _pegarTempoDoUsuario(oTempoInicial: true);
                        },
                        icon: const Icon(
                          Icons.access_time_filled_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: InputAgendamentos(
                      titulo: "Tempo Final",
                      dica: tempoFinal,
                      widget: IconButton(
                        onPressed: () {
                          _pegarTempoDoUsuario(oTempoInicial: false);
                        },
                        icon: const Icon(
                          Icons.access_time_filled_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  )
                ],
              ),

              InputAgendamentos(
                titulo: "Lembrete",
                dica: "$_lenbreteSelecionado minutos restantes",
                widget: DropdownButton(
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
                      _lenbreteSelecionado = int.parse(novoValor!);
                    });
                  },
                    
                  items: listaLembrete.map<DropdownMenuItem<String>>((int valor) {
                    return DropdownMenuItem<String>(
                      value: valor.toString(),
                      child: Text(valor.toString()),
                    );
                  }).toList(),
                )
              ),
              
              const SizedBox(height: 18),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _paletaDeCor(),
                  Botao(
                    label: "Criar",
                    onTap: () {
                      vm.validaDados(
                        titulo: _tituloController.text, 
                        nota: _notaController.text, 
                        data: DateFormat('dd/MM/yyyy').format(dataSelecionada), 
                        timeInicial: tempoInicial, 
                        timeFinal: tempoFinal, 
                        lembrete: '', 
                        context: context
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _paletaDeCor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cores",
          style: tituloStyle,
        ),
        const SizedBox(height: 18),
        Wrap(
          children: List<Widget>.generate(
            3, (int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _corSelecionada = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                    ? Colors.black : index == 1
                    ? Colors.red   : Colors.amber,
                    child: _corSelecionada == index
                      ? const Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 16,
                        )
                      : Container(),
                  ),
                ),
              );
            }
          ),
        ),
      ],
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
      dataSelecionada = pegarData;
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
