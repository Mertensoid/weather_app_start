import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_start/entity/weather.dart';
import 'package:weather_app_start/list_item.dart';
import 'package:weather_app_start/main.dart';

class DayHeading extends ListItem {
  final DateTime dateTime;

  DayHeading(this.dateTime);
}

class HeadingListItem extends StatelessWidget implements ListItem {
  static var _dateFormatWeekDay = DateFormat('EEEE');
  final DayHeading dayHeading;

  const HeadingListItem(this.dayHeading);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        children: [
          Text("${_dateFormatWeekDay.format(dayHeading.dateTime)} "
              "${dayHeading.dateTime.day}.${dayHeading.dateTime.month}",
          style: Theme.of(context).textTheme.headline6,),
          const Divider()
        ],
      ),
    );
  }
}