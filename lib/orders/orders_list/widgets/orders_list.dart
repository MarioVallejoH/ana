import 'package:customer_app/orders/orders_list/controllers/orders_list_controller.dart';

import 'package:customer_app/widgets/no_results.dart';
import 'package:customer_app/orders/orders_list/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersList extends GetView<OrdersListController> {
  const OrdersList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        return RefreshIndicator(
          onRefresh: () async {
            await controller.reloadData();
          },
          child: ListView.builder(
            // separatorBuilder: (context, index) {
            //   return Divider(
            //     height: 1,
            //     color: greyDLight,
            //     thickness: 0.2,
            //   );
            // },
            itemCount: state!.length,
            itemBuilder: (context, index) {
              final order = state[index];
              return OrderCard(
                orderModel: order,
              );
            },
          ),
        );
      },
      onEmpty: Center(
        child: NoResults(
          title: "No se encontraron pedidos",
          subTitle: "",
        ),
      ),
    );
    // return FutureBuilder<List<OrderModel>?>(
    //   future: OrdersService()
    //       .loadOrders(Get.find<AuthController>().state?.companyId ?? 0),
    //   builder:
    //       (BuildContext context, AsyncSnapshot<List<OrderModel>?> snapshot) {
    //     if (snapshot.hasData) {
    //       if (snapshot.data?.isNotEmpty ?? false) {
    //         return RefreshIndicator(
    //           onRefresh: () async {
    //             await controller.reloadData();
    //           },
    //           child: ListView.builder(
    //             // separatorBuilder: (context, index) {
    //             //   return Divider(
    //             //     height: 1,
    //             //     color: greyDLight,
    //             //     thickness: 0.2,
    //             //   );
    //             // },
    //             itemCount: snapshot.data!.length,
    //             itemBuilder: (context, index) {
    //               final order = snapshot.data![index];
    //               return OrderCard(
    //                 orderModel: order,
    //               );
    //             },
    //           ),
    //         );
    //       } else {
    //         return Center(
    //           child: NoResults(
    //             title: "No se encontraron pedidos",
    //             subTitle: "",
    //           ),
    //         );
    //       }
    //     }
    //     return const Center();
    //   },
    // );
  }
}
