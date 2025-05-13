import 'package:flutter/material.dart';
import 'package:iot_project/widgets/weather_log_card.dart';
import 'package:iot_project/widgets/weather_widget.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>().weather;

    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(title: const Text('Weather Monitor'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            weather == null
                ? const CircularProgressIndicator()
                : WeatherCard(weather: weather),
            const SizedBox(height: 20),
            const Text(
              "📜 Recent Logs",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            StreamBuilder(
              stream: context.watch<WeatherProvider>().weatherLogsStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                final logs = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: logs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: WeatherLogCard(weather: logs[index]),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
