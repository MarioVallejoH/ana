
import 'package:customer_app/products/product_details/services/product_details_service.dart';
import 'package:customer_app/products/products.dart';
import 'package:get/get.dart';

/// Controlador para la creación de fuel
class ProductDetailsController extends GetxController {
  /// Constructor
  ProductDetailsController({required this.service});

  /// Variable para acceder al servicio
  final ProductDetailService service;

  Future<Map<int, List<ProductPreference>>> getProductPrefs(
    int id,
  ) async {
    return service.getProductPreferences(id);
  }
}
