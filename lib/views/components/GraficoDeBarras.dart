import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraficoDeBarras extends StatelessWidget {
  final AsyncSnapshot<Map<String, int>> snapshot;

  GraficoDeBarras(this.snapshot);

  @override
  Widget build(BuildContext context) {
    List<int> agendamentosPorDia = [];

    if (snapshot.hasData) {
      final Map<String, int> dados = snapshot.data!;
      agendamentosPorDia = [
        dados['segunda-feira'] ?? 0,
        dados['terça-feira'] ?? 0,
        dados['quarta-feira'] ?? 0,
        dados['quinta-feira'] ?? 0,
        dados['sexta-feira'] ?? 0,
        dados['sábado'] ?? 0,
      ];
    }

    final coresColunas = [
      [Colors.red.shade300, Colors.red.shade500, Colors.red.shade900], 
      [Colors.orange.shade300, Colors.orange.shade500, Colors.orange.shade900], 
      [Colors.green.shade300, Colors.green.shade500, Colors.green.shade900], 
      [Colors.teal.shade300, Colors.teal.shade500, Colors.teal.shade900], 
      [Colors.blue.shade300, Colors.blue.shade500, Colors.blue.shade900], 
      [Colors.purple.shade300, Colors.purple.shade500, Colors.purple.shade900]
    ];

    return Column(
      children: [
        const Text('Quantidade de agendamentos por dia na semana'),
        Container(height: 30),
        SizedBox(
          height: 300,
          child: BarChart(
            BarChartData(
              barGroups: agendamentosPorDia
                .asMap()
                .entries
                .map(
                  (entry) => BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        y: entry.value.toDouble(), 
                        width: 20, 
                        borderRadius: BorderRadius.circular(5),
                        colors: coresColunas[entry.key],
                      ),
                    ],
                  ),
                )
                .toList(),
              
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid),
              ),
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                horizontalInterval: 1,
                drawVerticalLine: true,
                verticalInterval: 1,
              ),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.white,
                  fitInsideHorizontally: true,
                  fitInsideVertically: true,
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,
                  margin: 10,
                  reservedSize: 22,
                  getTitles: (value) {
                    final diasDaSemana = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];
                    if (value.toInt() >= 0 && value.toInt() < diasDaSemana.length) {
                      return diasDaSemana[value.toInt()];
                    }
                    return '';
                  },
                ),
                leftTitles: SideTitles(
                  showTitles: true,
                  margin: 10,
                  reservedSize: 22,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
