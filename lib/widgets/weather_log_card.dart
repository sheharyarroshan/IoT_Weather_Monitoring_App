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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Weather Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "🌡 ${weather.temperature.toStringAsFixed(1)} °C",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "💧 ${weather.humidity.toStringAsFixed(1)} %",
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
          // Time
          Text(
            time,
            style: const TextStyle(fontSize: 13, color: Colors.white),
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
