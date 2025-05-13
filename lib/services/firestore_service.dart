import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/weather.dart';

class FirestoreService {
  final _collection = FirebaseFirestore.instance.collection('weather_logs');

  Future<void> addWeather(Weather weather) async {
    await _collection.add({
      'temperature': weather.temperature,
      'humidity': weather.humidity,
      'timestamp': weather.timestamp.toIso8601String(),
    });
  }

  Stream<List<Weather>> getLogsStream() {
    return _collection
        .orderBy('timestamp', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return Weather(
              temperature: (data['temperature'] ?? 0).toDouble(),
              humidity: (data['humidity'] ?? 0).toDouble(),
              timestamp: DateTime.parse(data['timestamp']),
            );
          }).toList();
        });
  }
}
