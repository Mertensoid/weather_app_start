import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app_start/constants.dart';
import 'package:weather_app_start/entity/day_heading.dart';
import 'package:weather_app_start/entity/forecast_response_entity.dart';
import 'package:weather_app_start/entity/weather.dart';
import 'package:weather_app_start/list_item.dart';
import 'package:http/http.dart' as http;

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

  Future<List<ForecastResponseList>> getWeather(double lat, double lng) async {
    var queryParameters = {
      'APPID': Constants.WEATHER_APP_ID,
      'units': 'metric',
      'lat': lat.toString(),
      'lon': lng.toString(),
    };
    var uri = Uri.https(
        Constants.WEATHER_BASE_URL,
        Constants.WEATHER_FORECAST_URL,
        queryParameters
    );

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var forecastResponse = ForecastResponse.fromJson(json.decode(response.body));
      if (forecastResponse.cod == "200") {
        return forecastResponse.list;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                  Text('Error ${forecastResponse.cod}')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                Text('Error')));
    }
    return <ForecastResponseList>[];
  }

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

/// MARK: - Some functions
