// ignore_for_file: unnecessary_string_escapes

import 'dart:convert';
import 'dart:math';

import 'package:intl/intl.dart';


// import 'dart:math';

Map<String, dynamic> replaceStringInMap(
    Map map, String oldString, String newString) {
  String stMap = jsonEncode(map);

  stMap.replaceAll(oldString, newString);

  return jsonDecode(stMap);
}

bool isNumeric(String s) {
  // ignore: unnecessary_null_comparison
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

bool isNumericInt(String s) {
  // ignore: unnecessary_null_comparison
  if (s == null) {
    return false;
  }
  return int.tryParse(s) != null;
}

List getKeyValuesOfListMap(List<Map> map, String key) {
  if (map.isNotEmpty) {
    final List temp = [];
    try {
      for (var m in map) {
        temp.add(m[key]);
      }
      // ignore: empty_catches
    } catch (e) {}
    return temp;
  } else {
    return [];
  }
}
// int abd(int i){
//   return int.parse(sqrt().toString());
// }

String getFormatedCurrency(double value, {int? decimals}) {
  NumberFormat _formatCurrency = NumberFormat.simpleCurrency(
      decimalDigits: decimals);
  if (value.floor() == value.toInt()) {
    _formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 0);
  }
  return _formatCurrency.format(value);
}

double roundDouble(double value, int places) {
  double mod = pow(10.0, places).toDouble();
  return ((value * mod).round().toDouble() / mod);
}

String getRoundedQtty(double double) {
  double = roundDouble(double, 1);
  String value = '';
  if (double.toString().endsWith('.0')) {
    value = double.toInt().toString();
  } else {
    value = double.toString();
  }
  return value;
}

// copy this code to somewhere in your dart file
// also you can write/add methods to below code to support your strings to modify i.e. `toCapitalize()` or `yourStringModifyingMethod`.

extension StringCasingExtension on String {
  String toCapitalize() {
    return length > 0
        ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}'
        : '';
  }
  // String yourStringModifyingMethod() => write your logic here to modify the string as per your need;
}

String capitalizeText(String value) {
  // final specialUpperCases = [
  //   's.a',
  //   'sa',
  //   'sas',
  //   's.a.s',
  //   'pos',
  //   's.a.s.',
  //   'pvp',
  //   'iva',
  //   'fb',
  //   '"adis"'
  // ];+
  value = Bidi.stripHtmlIfNeeded(value);
  value = value.trimRight();
  value = value.trimLeft();
  return value.toCapitalize();
}

String removeRareSpaceChr(String input) {
  input = input.trimRight();
  input = input.trimLeft();

  return input;
}

String getStringFromValues(var values) {
  String string = '';

  for (var i = 0; i < values.length; i++) {
    if (i == 0) {
      if (values.elementAt(i) == null || values.elementAt(i) == '') {
        string = string + "null";
      } else {
        var val = values.elementAt(i);
        String valString;
        if (val is String) {
          valString = val;
          try {
            final temp = jsonDecode(valString);
            if ((temp is! Map)) {
              valString = valString.replaceAll('"', '\"').replaceAll("'", "\'");
            }
          } catch (e) {
            // printConsole(e);
          }
        } else if (val is num) {
          valString = val.toString();
        } else {
          if (val is Map) {
            valString = jsonEncode(val);
            // valString =  valString.replaceAll(from, replace)
          } else {
            valString =
                val.toString().replaceAll('"', '\"').replaceAll("'", "\'");
          }
        }
        // printConsole(valString);
        string = string + '"' + valString + '"';
      }
    } else {
      if (values.elementAt(i) == null) {
        string = string + ",null";
      } else {
        var val = values.elementAt(i);
        String valString;
        if (val is String) {
          valString = val;
          try {
            final temp = jsonDecode(valString);
            if (temp is! num) {
              if ((temp is! Map)) {
                valString =
                    valString.replaceAll('"', '\"').replaceAll("'", "\'");
              } else {
                valString = valString
                    .replaceAll('"{', '{')
                    .replaceAll('}"', '}')
                    .replaceAll('"', "'");
              }
            }
          } catch (e) {
            // printConsole(e);
          }
        } else if (val is num) {
          valString = val.toString();
        } else {
          if (val is Map) {
            valString = jsonEncode(val);
            valString = valString
              ..replaceAll('"{', '{')
                  .replaceAll('}"', '}')
                  .replaceAll('"', "'");
            // valString =  valString.replaceAll(from, replace)
          } else {
            valString =
                val.toString().replaceAll('"', '\"').replaceAll("'", "\'");
          }
        }
        // printConsole(valString);
        // if(jsonDecode(valString)is Map){
        string = string + ',"' + valString + '"';
        // }else{
        //   // ignore: unnecessary_string_escapes
        //   valString = valString.replaceAll('"', '\"').replaceAll("'", "\'");
        //   string = string + ',"' + valString + '"';
        // }
        // string = string + ',"' + valString + '"';
      }
    }
  }

  return string.replaceAll('""{', '"{').replaceAll('}""', '}"');
}

String getEmptySpaces(int n) {
  String empty = ' ';

  return empty * n;
}
