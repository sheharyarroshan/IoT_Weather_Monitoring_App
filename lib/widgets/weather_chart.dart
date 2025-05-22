import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/weather.dart';

class WeatherChart extends StatefulWidget {
  final List<Weather> logs;

  const WeatherChart({super.key, required this.logs});

  @override
  State<WeatherChart> createState() => _WeatherChartState();
}

class _WeatherChartState extends State<WeatherChart> {
  bool showTemp = true;
  bool showHumidity = true;

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> tempSpots = [];
    final List<FlSpot> humiditySpots = [];

    for (int i = 0; i < widget.logs.length; i++) {
      tempSpots.add(FlSpot(i.toDouble(), widget.logs[i].temperature));
      humiditySpots.add(FlSpot(i.toDouble(), widget.logs[i].humidity));
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.2),
              Colors.white.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white30),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📊 Temperature & Humidity',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                FilterChip(
                  label: const Text("Temperature"),
                  selected: showTemp,
                  onSelected: (_) => setState(() => showTemp = !showTemp),
                  selectedColor: Colors.orangeAccent.withOpacity(0.3),
                  backgroundColor: Colors.white10,
                  labelStyle: const TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 10),
                FilterChip(
                  label: const Text("Humidity"),
                  selected: showHumidity,
                  onSelected:
                      (_) => setState(() => showHumidity = !showHumidity),
                  selectedColor: Colors.lightBlueAccent.withOpacity(0.3),
                  backgroundColor: Colors.white10,
                  labelStyle: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true, drawVerticalLine: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.black87,
                      getTooltipItems: (List<LineBarSpot> touchedSpots) {
                        return touchedSpots.map((spot) {
                          final label =
                              spot.bar.gradient?.colors.first ==
                                      Colors.orangeAccent
                                  ? '🌡 Temp'
                                  : '💧 Hum';
                          return LineTooltipItem(
                            '$label: ${spot.y.toStringAsFixed(1)}',
                            const TextStyle(color: Colors.white),
                          );
                        }).toList();
                      },
                    ),
                    handleBuiltInTouches: true,
                  ),
                  lineBarsData: [
                    if (showTemp)
                      LineChartBarData(
                        spots: tempSpots,
                        isCurved: true,
                        color: Colors.orangeAccent,
                        barWidth: 3,
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.orangeAccent.withOpacity(0.1),
                        ),
                        dotData: FlDotData(show: false),
                      ),
                    if (showHumidity)
                      LineChartBarData(
                        spots: humiditySpots,
                        isCurved: true,
                        color: Colors.lightBlueAccent,
                        barWidth: 3,
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.lightBlueAccent.withOpacity(0.1),
                        ),
                        dotData: FlDotData(show: false),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
