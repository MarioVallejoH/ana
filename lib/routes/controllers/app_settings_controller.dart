// import 'package:customer_app/data/services/app_settings_service.dart';
import 'package:customer_app/routes/models/app_settings_model.dart';
import 'package:customer_app/routes/services/app_settings_service.dart';
import 'package:get/get.dart';

class AppSettingsController extends GetxController
    with StateMixin<AppSettingsModel?> {
  AppSettingsController({required this.service}) {
    change(null, status: RxStatus.loading());
  }

  @override
  void onInit() async {
    await getAppSettings();
    super.onInit();
  }

  final AppSettingsService service;
  // final AppSettingsModel? appSettings;

  /// Método para obtener tipos de combustible basados en el vehículo actual
  Future<void> getAppSettings() async {
    final response = await service.getAppSettings();
    if (response != null) {
      change(response, status: RxStatus.success());
      return;
    }

    change(null, status: RxStatus.error('Error al cargar datos de inicio'));
  }
}
