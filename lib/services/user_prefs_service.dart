import 'package:nb_utils/nb_utils.dart';

class UserPrefsService {
  static Future<void> saveUserPrefs(Map<String, dynamic> prefs) async {
    await setValue("user_prefs", prefs);
  }

  static Future<void> saveUserSelectedAddres(String addressId) async {
    await setValue("user_sel_address", addressId);
  }

  static String get userPrefs => getStringAsync("user_prefs");

  static String get userSelectedAddress => getStringAsync("user_sel_address");

}
