import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/weather_log_card.dart';
import '../widgets/weather_chart.dart'; // <--- Add this

class LogsScreen extends StatelessWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Recent Logs'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF89C5FD), Color(0xFF6A82FB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: StreamBuilder(
            stream: context.watch<WeatherProvider>().weatherLogsStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final logs = snapshot.data!;

              return logs.isEmpty
                  ? const Center(
                    child: Text(
                      "No logs available",
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                  )
                  : ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      WeatherChart(logs: logs),
                      const SizedBox(height: 20),
                      ...logs.map(
                        (log) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: WeatherLogCard(weather: log),
                        ),
                      ),
                    ],
                  );
            },
          ),
        ),
      ),
    );
  }
}
