import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/models/weather_model.dart';
import 'package:myapp/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherServices = WeatherService('06541f8c05e1596a2d1a95269abb7301');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherServices.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherServices.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  // weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/cloud.json'; // default animation

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/storm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/cloud.json';
    }
  }

  @override
  void initState() {
    super.initState();

    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    String? temp = _weather?.temperature.round().toString() ?? '--';

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(
              _weather?.cityName ?? "Loading city...",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),

            // animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            // temperature
            Text(
              '$temp °C',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            ),

            // condition
            Text(_weather?.mainCondition ?? ""),
          ],
        ),
      ),
    );
  }
}
