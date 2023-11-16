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

    return Column(
      children: [
        const Text('Quantidade de agendamentos por dia'),
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
                      x: entry.key + 1,
                      barRods: [
                        BarChartRodData(y: entry.value.toDouble()),
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
                  margin: 20,
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
                  margin: 20,
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
