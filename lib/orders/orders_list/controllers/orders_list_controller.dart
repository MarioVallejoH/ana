import 'package:customer_app/models/companies_model.dart';
import 'package:customer_app/orders/orders_list/models/order_model.dart';
import 'package:customer_app/orders/orders_list/services/orders_service.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

/// Controlador para la creación de fuel
class OrdersListController extends GetxController
    with StateMixin<List<OrderModel>?> {
  /// Constructor
  OrdersListController({required this.service, required this.company}) {
    change(null, status: RxStatus.loading());
  }

  /// Variable para acceder al servicio
  final OrdersService service;

  final CompanyModel? company;

  OrderModel? selectedOrder;

  bool orderGotCancelled = false;

  Future<void> loadData() async {
    final orders = await service.loadOrders(company?.id ?? 0);
    change(orders, status: RxStatus.success());
  }

  Future<void> reloadData() async {
    change(null, status: RxStatus.loading());
    final orders = await service.loadOrders(company?.id ?? 0);
    change(orders,
        status: orders.isEmpty ? RxStatus.empty() : RxStatus.success());
  }

  void changeOrderStatus(int orderId) {
    try {
      state?.firstWhere((element) => element.id == orderId).saleStatus =
          "cancelled";
    } catch (e) {
      log(e);
    }
    change(state, status: RxStatus.success());
    orderGotCancelled = false;
  }
}
