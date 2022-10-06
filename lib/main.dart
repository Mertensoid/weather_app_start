import 'package:flutter/material.dart';
import 'package:weather_app_start/day_heading.dart';
import 'package:weather_app_start/entity/weather.dart';
import 'package:weather_app_start/list_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const WeatherForecastPage("Moscow");
  }
}

class WeatherForecastPage extends StatefulWidget {

  final String cityName;

  const WeatherForecastPage(this.cityName);

  @override
  State<StatefulWidget> createState() {
    return _WeatherForecastPageState();
  }
}

class _WeatherForecastPageState extends State<WeatherForecastPage> {
  List<ListItem> weatherForecast = <ListItem>[];

  @override
  void initState() {
    var itCurrentDay = DateTime.now();
    weatherForecast.add(DayHeading(itCurrentDay));
    List<Weather> weatherData = [
      Weather(itCurrentDay, 20, 90, "04d"),
      Weather(itCurrentDay.add(const Duration(hours: 3)), 23, 50, "03d"),
      Weather(itCurrentDay.add(const Duration(hours: 6)), 25, 50, "02d"),
      Weather(itCurrentDay.add(const Duration(hours: 9)), 28, 50, "01d"),
      Weather(itCurrentDay.add(const Duration(hours: 12)), 25, 50, "02d"),
      Weather(itCurrentDay.add(const Duration(hours: 15)), 23, 50, "03d"),
      Weather(itCurrentDay.add(const Duration(hours: 18)), 28, 70, "01d"),
      Weather(itCurrentDay.add(const Duration(hours: 21)), 25, 50, "02d"),
      Weather(itCurrentDay.add(const Duration(hours: 24)), 23, 50, "03d"),
      Weather(itCurrentDay.add(const Duration(hours: 27)), 23, 60, "03d"),
      Weather(itCurrentDay.add(const Duration(hours: 30)), 28, 70, "01d"),
      Weather(itCurrentDay.add(const Duration(hours: 33)), 25, 50, "02d"),
      Weather(itCurrentDay.add(const Duration(hours: 36)), 23, 50, "03d"),
      Weather(itCurrentDay.add(const Duration(hours: 39)), 23, 60, "03d"),
      Weather(itCurrentDay.add(const Duration(hours: 42)), 23, 50, "03d"),
      Weather(itCurrentDay.add(const Duration(hours: 45)), 28, 50, "01d"),
    ];
    var itNextDay = DateTime.now().add(Duration(days: 1));
    itNextDay = DateTime(itNextDay.year, itNextDay.month, itNextDay.day,
        0, 0, 0, 0, 1);
    var iterator = weatherData.iterator;
    while (iterator.moveNext()) {
      var weatherDateTime = iterator.current as Weather;
      if (weatherDateTime.dateTime.isAfter(itNextDay)) {
        itCurrentDay = itNextDay;
        itNextDay = itCurrentDay.add(Duration(days: 1));
        itNextDay = DateTime(itNextDay.year, itNextDay.month, itNextDay.day,
            0, 0, 0, 0, 1);
        weatherForecast.add(DayHeading(itCurrentDay));
      } else {
        weatherForecast.add(iterator.current);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ListView sample",
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Weather forecast'),
        ),
        body: ListView.builder(
          itemCount: weatherForecast.length,
          itemBuilder: (BuildContext context, int index) {
            final item = weatherForecast[index];
            if (item is Weather) {
              return WeatherListItem(item);
            } else if (item is DayHeading) {
              return HeadingListItem(item);
            } else {
              throw Exception('Wrong type');
            }
          }))
    );
  }
}
