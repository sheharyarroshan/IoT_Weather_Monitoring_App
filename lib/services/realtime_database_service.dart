import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  Stream<DatabaseEvent> getWeatherData() {
    return _dbRef.child('weather').onValue;
  }
}
