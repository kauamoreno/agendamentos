import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Relatórios',
      theme: ThemeData(
        primarySwatch: Colors.red,
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
  String selectedRoomType = 'Todas as Salas'; // Valor padrão

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatórios'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinhar à esquerda
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.analytics,
                    color: Colors.red,
                    size: 50.0,
                  ),
                ),
                Text(
                  'Filtrar por Sala:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                value: selectedRoomType,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRoomType = newValue!;
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
            ),
            // Conteúdo do relatório aqui...
          ],
        ),
      ),
    );
  }
}
