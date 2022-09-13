import 'package:customer_app/utils/formating/data_formating.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String parseDateStrES(String inputString) {
  initializeDateFormatting('es'); // This will initialize Spanish locale
  DateFormat format = DateFormat.yMMMMEEEEd('es');
  String res = '';
  try {
    res = format.format(DateTime.parse(inputString));
    // ignore: empty_catches
  } catch (e) {}
  return capitalizeText(res);
}

String parseDateStrESWoutYear(String inputString) {
  initializeDateFormatting('es'); // This will initialize Spanish locale
  DateFormat format = DateFormat.MMMMEEEEd('es');
  String res = '';
  try {
    res = format.format(DateTime.parse(inputString));
    // ignore: empty_catches
  } catch (e) {}
  return capitalizeText(res);
}

String parseTimeStrES(String inputString) {
  initializeDateFormatting('es'); // This will initialize Spanish locale
  DateFormat format = DateFormat.Hm('es');
  try {
    return format.format(DateTime.parse(inputString));
  } catch (e) {
    return '';
  }
}

String formatTimeOfDay(TimeOfDay tod) {
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  final format = DateFormat.jm(); //"6:00 AM"
  return format.format(dt);
}

String formatOnlyDate(DateTime date) {
  final format = DateFormat('yyyy-MM-dd'); //"6:00 AM"
  return format.format(date);
}
