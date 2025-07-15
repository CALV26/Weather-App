import 'package:flutter/material.dart';
import 'package:myapp/data/notifiers.dart';
import 'pages/weather_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    

    return ValueListenableBuilder(
      valueListenable: mainConditionNotifier,
      builder: (context, mainCondition, child) {
        Brightness currentBrightness;
        if (
          mainCondition == 'rain' || 
          mainCondition == 'drizzle' || 
          mainCondition == 'shower rain' || 
          mainCondition == 'thunderstorm') {
          currentBrightness = Brightness.dark;
        } else {
          currentBrightness = Brightness.light;
        }

        return MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white,
              brightness: currentBrightness,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: WeatherPage(),
        );
      },
    );
  }
}