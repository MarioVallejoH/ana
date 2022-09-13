import 'package:customer_app/utils/parsing/numeric_paring.dart';
import 'package:flutter/material.dart';

TimeOfDay parseTimeOfDay(String time) {
  final timeParts = time.split(":");

  final timeOfDay = TimeOfDay(
      hour: parsingToInt(timeParts[0]), minute: parsingToInt(timeParts[1]));
  return timeOfDay;
}