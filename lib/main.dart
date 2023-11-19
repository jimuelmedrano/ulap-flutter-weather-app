import 'package:flutter/material.dart';
import 'package:ulap_flutter_weather_app/pages/weather_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const UlapApp());
}

class UlapApp extends StatelessWidget {
  const UlapApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ulap Weather',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: const WeatherPage(),
    );
  }
}
