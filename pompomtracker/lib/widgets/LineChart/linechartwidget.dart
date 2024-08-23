import 'dart:developer';

import 'package:intl/intl.dart';

import '../../core/hook/hook.dart';

class Linechartwidget extends StatelessWidget {
  const Linechartwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ValueListenableBuilder(
        valueListenable: Wklycollectfn.instance.wklycollectionNotifier,
        builder: (BuildContext context, List<Buswklycollectlist> newList,
            Widget? _) {
          return newList.isEmpty
              ? Container()
              : LineChart(LineChartData(
                  minX: 0,
                  maxX: (newList.length - 1).toDouble(),
                  minY: 0,
                  maxY: 20000,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true,
                          //reservedSize: 20,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index >= 0 && index < newList.length) {
                              final date = newList[index].paydate;
                              if (date != null) {
                                DateTime axisDate =
                                    DateFormat("dd-MM-yyyy").parse(date);
                                // Format the date to show day and month
                                String formattedDate =
                                    DateFormat('d/M').format(axisDate);
                                return Transform.rotate(
                                  angle: 5,
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      formattedDate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ),
                                );
                              }
                            }
                            return const Text('');
                          },
                          interval: 1),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 5000, // Adjust for Y-axis
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}',
                            style: Theme.of(context).textTheme.labelMedium,
                          );
                        },
                        reservedSize: 40,
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                      show: true,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                            color: Theme.of(context).colorScheme.primaryFixed,
                            strokeWidth: 1);
                      },
                      drawVerticalLine: true,
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: Theme.of(context).colorScheme.primaryFixed,
                          strokeWidth: 1,
                        );
                      }),
                  borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primaryFixed,
                          width: 1)),
                  lineBarsData: [
                    LineChartBarData(
                        spots: getWklyAmnt(newList),
                        isCurved: true,
                        barWidth: 5,
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary
                            ]))
                  ],
                  lineTouchData: LineTouchData(
                    enabled: true,
                    touchTooltipData: LineTouchTooltipData(
                      //tooltipBgColor: const Color.fromRGBO(68, 138, 255, 1),
                      getTooltipItems: (List<LineBarSpot> touchedSpots) {
                        return touchedSpots.map((spot) {
                          final amount = spot.y;
                          final date = newList[spot.x.toInt()].paydate;
                          return LineTooltipItem(
                            '${DateFormat('d/MM/yy').format(DateFormat("dd-MM-yyyy").parse(date!))}\n$amount',
                            const TextStyle(color: Colors.white),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ));
        },
      ),
    );
  }
}

List<FlSpot> getWklyAmnt(List<Buswklycollectlist> newList) {
  List<FlSpot> wklyCollectList = [];
  for (int i = 0; i < newList.length; i++) {
    final amount = newList[i].amount;
    log('$amount');
    double amnt = double.parse('$amount');
    // Use the index as X value (simple solution)
    wklyCollectList.add(FlSpot(i.toDouble(), amnt));
  }
  return wklyCollectList;
}
