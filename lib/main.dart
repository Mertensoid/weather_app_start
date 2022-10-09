import 'package:flutter/material.dart';
import 'package:weather_app_start/weather_forecast_page.dart';

/// MARK: - MyApp widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const WeatherForecastPage("Moscow");
  }
}

/// MARK: - Точка входа в приложение
void main() {
  runApp(const MyApp());
}







