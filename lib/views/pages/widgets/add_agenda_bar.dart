import 'package:agendamentos/views/pages/Temas.dart';
import 'package:agendamentos/views/pages/widgets/botao.dart';
import 'package:agendamentos/views/pages/widgets/inputs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class addAgendametoPagina extends StatefulWidget {
  const addAgendametoPagina({super.key});

  @override
  State<addAgendametoPagina> createState() => _addAgendametoPaginaState();
}

class _addAgendametoPaginaState extends State<addAgendametoPagina> {
  // final TaskControle _taskControle = Get.put(TaskControle());
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

  String _lenbreteSelecionadoRepetir = "Nenhum";
  List<String> listaRepetir = [
    "Nenhum",
    "Diário",
    "Semanalmente",
    "Mensalmente"
  ];

  int _corSelecionada = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _AppBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Add Agendamento",
                style: headingStyle,
              ),
              //CRUD DO AGENDAMENTO
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
                dica: DateFormat.yMd().format(dataSelecionada),
                widget: IconButton(
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _pegarDataDoUsuario();
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
                      icon: Icon(
                        Icons.access_time_filled_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  )),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: InputAgendamentos(
                    titulo: "Tempo Final",
                    dica: tempoFinal,
                    widget: IconButton(
                      onPressed: () {
                        _pegarTempoDoUsuario(oTempoInicial: false);
                      },
                      icon: Icon(
                        Icons.access_time_filled_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ))
                ],
              ),
              InputAgendamentos(
                  titulo: "Lembrete",
                  dica: "$_lenbreteSelecionado minutos restantes",
                  widget: DropdownButton(
                    icon: Icon(
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
                    items: listaLembrete
                        .map<DropdownMenuItem<String>>((int valor) {
                      return DropdownMenuItem<String>(
                        value: valor.toString(),
                        child: Text(valor.toString()),
                      );
                    }).toList(),
                  )),
              InputAgendamentos(
                  titulo: "Repetir",
                  dica: "$_lenbreteSelecionadoRepetir",
                  widget: DropdownButton(
                    icon: Icon(
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
                        _lenbreteSelecionadoRepetir = novoValor!;
                      });
                    },
                    items: listaRepetir
                        .map<DropdownMenuItem<String>>((String? valor) {
                      return DropdownMenuItem<String>(
                        value: valor.toString(),
                        child: Text(
                          valor!,
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }).toList(),
                  )),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _paletaDeCor(),
                   Botao(label: "Criar Age", onTap: () {  },)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // _validacaoDeData() {
  //   if (_tituloController.text.isNotEmpty && _notaController.text.isNotEmpty) {
  //     _addAgendamentoParaODb();
  //     Get.back();
  //   } else if (_tituloController.text.isEmpty || _notaController.text.isEmpty) {
  //     Get.snackbar("Requerido", " Todos os campos são obrigatorios!",
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.white,
  //         icon: Icon(
  //           Icons.warning_amber_rounded,
  //           color: Colors.red,
  //         ));
  //   }
  // }

  // _addAgendamentoParaODb() async {
  //   int valor = await _taskControle.addTask(
  //       task: Task(
  //     nota: _notaController.text,
  //     titulo: _tituloController.text,
  //     data: DateFormat.yMd().format(dataSelecionada),
  //     tempoInicial: tempoInicial,
  //     tempoFinal: tempoFinal,
  //     lembrar: _lenbreteSelecionado,
  //     repetir: _lenbreteSelecionadoRepetir,
  //     cor: _corSelecionada,
  //     estaCompleto: 0,
  //   ));
  //   print("Meu id é" + "$valor");
  // }

  _paletaDeCor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cores",
          style: tituloStyle,
        ),
        SizedBox(height: 18),
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _corSelecionada = index;
                  print("$index");
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? primaryClr
                        : index == 1
                            ? rosaClr
                            : amareloClr,
                    child: _corSelecionada == index
                        ? Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16,
                          )
                        : Container()),
              ),
            );
          }),
        ),
      ],
    );
  }

  _AppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [],
    );
  }

  _pegarDataDoUsuario() async {
    DateTime? pegarData = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2100));

    if (pegarData != null) {
      setState(() {
        dataSelecionada = pegarData;
        print(dataSelecionada);
      });
    } else {}
  }

  _pegarTempoDoUsuario({required bool oTempoInicial}) async {
    var pegarTempo = await exibirTempoDoUsuario();
    String _tempoFormatado = pegarTempo.format(context);
    if (pegarTempo == null) {
      print("");
    } else if (oTempoInicial == true) {
      setState(() {
        tempoInicial = _tempoFormatado;
      });
    } else if (oTempoInicial == false) {
      setState(() {
        tempoFinal = _tempoFormatado;
      });
    }
  }

  exibirTempoDoUsuario() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(tempoInicial.split(":")[0]),
            minute: int.parse(tempoInicial.split(":")[1].split(" ")[0])));
  }
}
