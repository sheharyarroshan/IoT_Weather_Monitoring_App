import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather.dart';

class WeatherLogCard extends StatelessWidget {
  final Weather weather;

  const WeatherLogCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final time = DateFormat('yyyy-MM-dd – hh:mm a').format(weather.timestamp);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white38),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "🌡 ${weather.temperature.toStringAsFixed(1)} °C",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "💧 ${weather.humidity.toStringAsFixed(1)} %",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
          Text(time, style: const TextStyle(fontSize: 13, color: Colors.white)),
        ],
      ),
    );
  }
}
