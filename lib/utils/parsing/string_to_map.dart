import 'package:nb_utils/nb_utils.dart';

Map stringToIntsMap(String mapString) {
  final Map map = {};
  mapString = mapString.replaceAll('{', '').replaceAll('}', '');
  final parts = mapString.split(',');
  for (String element in parts) {
    try {
      final parts2 = element.split(':');
      final prefsIds = parts2[1].replaceAll('[', '').replaceAll(']', '');
      final idsList = [];
      prefsIds.split(',').forEach((element) {
        idsList.add(int.tryParse(element));
      });
      map[int.tryParse(parts2[0])] = idsList;
    } catch (e) {
      log(e);
    }
  }
  return map;
}
