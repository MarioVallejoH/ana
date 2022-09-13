// To parse this JSON data, do
//
//     final deliveryTime = deliveryTimeFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

import '../utils/formating/date_to_text.dart';
import '../utils/parsing/numeric_paring.dart';
import '../utils/parsing/time_of_day.dart';

class DeliveryTime {
  DeliveryTime({
    required this.id,
    required this.day,
    required this.time1,
    required this.time2,
  });

  int id;
  String day;
  TimeOfDay time1;
  TimeOfDay time2;

  factory DeliveryTime.fromRawJson(String str) =>
      DeliveryTime.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeliveryTime.fromJson(Map<String, dynamic> json) => DeliveryTime(
        id: parsingToInt(json["id"]),
        day: json["day"]?.toString() ?? "",
        time1: parseTimeOfDay(json["time_1"]),
        time2: parseTimeOfDay(json["time_2"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "time_1": time1,
        "time_2": time2,
      };

  static List<DeliveryTime> fromJsonList(List list) {
    List<DeliveryTime> deliveryTimes = [];
    Map<String, dynamic> temp = {};
    for (var item in list) {
      for (var i = 0; i < item.keys.length; i++) {
        temp[item.keys.toList()[i]] = item.values.toList()[i];
      }
      deliveryTimes.add(DeliveryTime.fromJson(temp));
    }

    return deliveryTimes;

    // prString(temp);
  }

  String getDelvTimeText() {
    String text = '';

    final part1 = formatTimeOfDay(time1).toLowerCase();

    text = part1;

    final part2 = formatTimeOfDay(time2).toLowerCase();

    text += ' a ' + part2;

    return text;
  }

  @override
  String toString() {
    return getDelvTimeText();
  }
}
