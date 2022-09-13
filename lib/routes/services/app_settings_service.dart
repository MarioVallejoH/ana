import 'package:customer_app/endpoints_dir.dart';
import 'package:customer_app/providers/data_provider.dart';
import 'package:customer_app/routes/models/app_settings_model.dart';

class AppSettingsService {
  Future<AppSettingsModel?> getAppSettings() async {
    final apiData = await DataProvider.getPetition(appSettingsEndP);

    if (apiData['success'] ?? false) {
      if (apiData['data'] != null) {
        final appSettings = AppSettingsModel.fromJson(apiData['data']);
        return appSettings;
      }
    } else {
      return AppSettingsModel();
    }
    return null;
  }
}
