import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Controlador del estado de la conexión
class ConnectivityController extends GetxController {
  /// Constructor
  ConnectivityController() {
    _initConnectivity();
    _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  static bool _connection = true;
  final Connectivity _connectivity = Connectivity();

  Future<void> _initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result != ConnectivityResult.none) {
      // _reloadAndSendData();
      _connection = true;
      return;
    }
    _connection = false;
  }

  // Future<void> _reloadAndSendData() async {
  //   const storage = FlutterSecureStorage();
  //   final lastChecklist = await storage.read(key: 'lastChecklist');
  //   if (lastChecklist != null) {
  //     final map = jsonDecode(lastChecklist);
  //     await storage.delete(key: 'lastChecklist');
  //     await CreateChecklistService().createChecklist(map);
  //   }
  //   if (Get.currentRoute == '/vehicleHome') {
  //     if (Get.find<VehicleController>().state!.isEmpty) {
  //       await Get.find<VehicleController>().loadListTop();
  //     }
  //   }
  // }

  /// Método para validar el estado de la conexión a internet
  bool validateConnection({
    BuildContext? context,
  }) {
    if (_connection) {
      return true;
    }

    if (context != null) {
      Get.showSnackbar(
        const GetSnackBar(
          message:
              'Por favor, verifique la conexión a internet e intente de nuevo más tarde.',
        ),
      );
      return false;
    }

    return false;
  }
}
