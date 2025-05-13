import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../models/weather.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({super.key, required this.weather});

  String getLottieAsset() {
    if (weather.temperature! > 30) return 'assets/animations/sunny.json';
    if (weather.temperature! < 15) return 'assets/animations/rainy.json';
    return 'assets/animations/cloudy.json';
  }

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat('hh:mm a').format(weather.timestamp);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade200.withOpacity(0.5),
            Colors.blue.shade400.withOpacity(0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text("Real-Time Data", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Row(
            children: [
              //lottie animation
              Lottie.asset(getLottieAsset(), width: 120),
              const SizedBox(width: 16),
              Column(
                children: [
                  Text(
                    "🌡 Temp: ${weather.temperature.toStringAsFixed(1)} °C",
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    "💧 Humidity: ${weather.humidity.toStringAsFixed(1)} %",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "⏱ $formattedTime",
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
