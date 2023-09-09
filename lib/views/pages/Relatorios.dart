import 'package:agendamentos/views/components/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relatórios',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RelatoriosPage(),
    );
  }
}

class RelatoriosPage extends StatefulWidget {
  @override
  _RelatoriosPageState createState() => _RelatoriosPageState();
}

class _RelatoriosPageState extends State<RelatoriosPage> {
  String selecionarTipoSala = 'Todas as Salas'; // Valor padrão

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titulo: "Relatorios"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.analytics,
              size: 100.0,
              color: Colors.red,
            ),
            SizedBox(height: 20.0),
            Text(
              'Seus Relatórios',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            DropdownButton<String>(
              value: selecionarTipoSala,
              onChanged: (String? newValue) {
                setState(() {
                  selecionarTipoSala = newValue!;
                });
              },
              items: <String>[
                'Todas as Salas',
                'Salas de Aula',
                'Salas de Informática',
                'Salas Eletroeletrônica',
                'Salas de Mecânica',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
