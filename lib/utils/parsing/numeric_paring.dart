double parsingToDouble(var value) {
  double d = 0.0;
  if (value != null) {
    if (value != '') {
      d = double.tryParse(value.toString()) ?? 0.0;
    }
  }
  return d;
}

double? parsingToDoubleNullAble(var value) {
  double? d;
  if (value != null) {
    if (value != '') {
      d = double.tryParse(value.toString()) ?? 0.0;
    }
  }
  return d;
}

int parsingToInt(var value, {int defaultValue = 0}) {
  int d = defaultValue;
  if (value != null) {
    if (value != '') {
      d = int.tryParse(value.toString()) ?? defaultValue;
    }
  }
  return d;
}

int? parsingToIntNullable(
  var value,
) {
  int? d;
  if (value != null) {
    if (value != '') {
      d = int.tryParse(value.toString());
    }
  }
  return d;
}
