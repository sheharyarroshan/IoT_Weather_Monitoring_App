import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/firestore_service.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  final _db = FirebaseDatabase.instance.ref().child('weather');
  final _firestoreService = FirestoreService();

  Weather? get weather => _weather;

  Stream<List<Weather>> get weatherLogsStream =>
      _firestoreService.getLogsStream();

  void startListening() {
    _db.onValue.listen((event) async {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        final newWeather = Weather(
          temperature: (data['temperature'] ?? 0).toDouble(),
          humidity: (data['humidity'] ?? 0).toDouble(),
          timestamp: DateTime.now(),
        );
        _weather = newWeather;
        notifyListeners();
        await _firestoreService.addWeather(newWeather);
      }
    });
  }
}
