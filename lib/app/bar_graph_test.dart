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

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1);
    final barGroup7 = makeGroupData(6, 19, 1);
    final barGroup8 = makeGroupData(7, 10, 1);
    final barGroup9 = makeGroupData(8, 10, 1);
    final barGroup10 = makeGroupData(9, 10, 1);
    final barGroup11 = makeGroupData(10, 10, 1);
    final barGroup12 = makeGroupData(11, 10, 1);
    final barGroup13 = makeGroupData(12, 12, 15);
    final barGroup14 = makeGroupData(13, 10, 1);
    final barGroup15 = makeGroupData(14, 9, 1);
    final barGroup16 = makeGroupData(15, 10, 1);
    final barGroup17 = makeGroupData(16, 10, 3);
    final barGroup18 = makeGroupData(17, 16, 5);
    final barGroup19 = makeGroupData(18, 10, 2);
    final barGroup20 = makeGroupData(19, 2, 1);
    final barGroup21 = makeGroupData(20, 10, 1);
    final barGroup22 = makeGroupData(21, 5, 1);
    final barGroup23 = makeGroupData(22, 8, 1);
    final barGroup24 = makeGroupData(23, 7, 1);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
      barGroup8,
      barGroup9,
      barGroup10,
      barGroup11,
      barGroup12,
      barGroup13,
      barGroup14,
      barGroup15,
      barGroup16,
      barGroup17,
      barGroup18,
      barGroup19,
      barGroup20,
      barGroup21,
      barGroup22,
      barGroup23,
      barGroup24,
    ];

    rawBarGroups = items;

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
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            );
          },
        ),
      );

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 3,
      showingTooltipIndicators: [0, 1],
      x: x,
      barRods: [
        BarChartRodData(
          borderRadius: BorderRadius.zero,
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          borderRadius: BorderRadius.zero,
          toY: y2,
          color: widget.rightBarColor,
          width: width,
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
    switch (value.toInt()) {
      case 0:
        text = '1h';
        break;
      case 1:
        text = '2h';
        break;
      case 2:
        text = '3h';
        break;
      case 3:
        text = '4h';
        break;
      case 4:
        text = '5h';
        break;
      case 5:
        text = '6h';
        break;
      case 6:
        text = '7h';
        break;
      case 7:
        text = '8h';
        break;
      case 8:
        text = '9h';
        break;
      case 9:
        text = '10h';
        break;
      case 10:
        text = '11h';
        break;
      case 11:
        text = '12h';
        break;
      case 12:
        text = '13h';
        break;
      case 13:
        text = '14h';
        break;
      case 14:
        text = '15h';
        break;
      case 15:
        text = '16h';
        break;
      case 16:
        text = '17h';
        break;
      case 17:
        text = '18h';
        break;
      case 18:
        text = '19h';
        break;
      case 19:
        text = '20h';
        break;
      case 20:
        text = '21h';
        break;
      case 21:
        text = '22h';
        break;
      case 22:
        text = '23h';
        break;
      case 23:
        text = '24h';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(text, style: style),
    );
  }
}
