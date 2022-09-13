import 'package:customer_app/endpoints_dir.dart';
import 'package:customer_app/orders/orders_list/models/order_model.dart';
import 'package:customer_app/providers/data_provider.dart';
// import 'package:customer_app/data/providers/orders_provider.dart';

class OrdersService {
  Future<List<OrderModel>> loadOrders(int companyId) async {
    final ordersData = await DataProvider.postPetition(
        orderListEndP, {"customer_id": companyId});

    if (ordersData['success'] ?? false) {
      final orders = OrderModel.fromJsonList(ordersData['data']);
      return orders;
    }

    return [];
  }
}
