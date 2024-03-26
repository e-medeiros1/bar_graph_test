import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomBarChart extends StatefulWidget {
  const CustomBarChart({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<CustomBarChart> createState() => _CustomBarChartState();
}

class _CustomBarChartState extends State<CustomBarChart> {
  @override
  Widget build(BuildContext context) {
    return const BarGraph();
  }
}

class BarGraph extends StatefulWidget {
  const BarGraph({super.key});

  final Color leftBarColor = const Color(0xFF004654);
  final Color rightBarColor = const Color(0xFF20a090);
  final Color avgColor = const Color(0xFF20a090);
  @override
  State<StatefulWidget> createState() => BarGraphState();
}

class BarGraphState extends State<BarGraph> {
  final double width = 10;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  List<dynamic> chartData = [];

  @override
  void initState() {
    super.initState();

    chartData = [
      {'hour': 1, 'bar1': 10.0, 'bar2': 7.0},
      {'hour': 3, 'bar1': 8.0, 'bar2': 9.0},
      {'hour': 4, 'bar1': 7.0, 'bar2': 5.0},
      {'hour': 5, 'bar1': 10.0, 'bar2': 11.0},
      {'hour': 7, 'bar1': 3.0, 'bar2': 15.0},
    ];

    rawBarGroups = chartData.map((item) => makeGroupData(item['hour'], item['bar1'], item['bar2'])).toList();
    chartData.sort((a, b) => a['hour'].compareTo(b['hour']));
    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: BarChart(
                BarChartData(
                  barTouchData: barTouchData,
                  titlesData: titlesData,
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
                  gridData: const FlGridData(show: false),
                  alignment: BarChartAlignment.spaceAround,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 1,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.toString(),
              textAlign: TextAlign.center,
              const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            );
          },
        ),
      );
  BarChartGroupData makeGroupData(int x, double? y1, double? y2) {
    final data = chartData.firstWhere((item) => item['hour'] == x, orElse: () => null);

    return BarChartGroupData(
      x: data?['hour'] ?? 0,
      barsSpace: 3,
      showingTooltipIndicators: [0, 1],
      barRods: [
        BarChartRodData(
          toY: data?['bar1'] ?? y1 ?? 0,
          color: widget.leftBarColor,
          width: width,
          borderRadius: BorderRadius.zero,
        ),
        BarChartRodData(
          toY: data?['bar2'] ?? y2 ?? 0,
          color: widget.rightBarColor,
          width: width,
          borderRadius: BorderRadius.zero,
        ),
      ],
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true, //Alterar pra true caso queira mostrar os bottom titles
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

//Bottom titles
  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontSize: 14,
    );
    String text;

    final matchingItem = chartData.firstWhere((item) => item['hour'] == value.toInt(), orElse: () => null);

    if (matchingItem == null) {
      text = '';
    } else {
      text = '${matchingItem['hour']}h';
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(text, style: style),
    );
  }
}
