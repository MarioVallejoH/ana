import 'package:customer_app/root/controllers/root_controller.dart';
import 'package:customer_app/theme/color.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersCount extends GetView<RootController> {
  const OrdersCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.ordersCount(),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        int ordersCount = 0;
        if (snapshot.hasData) {
          ordersCount = snapshot.data ?? 0;
        }
        return Text(
          'Has realizado: $ordersCount pedido(s)',
          style: ThemeConf().normalTextStyle(context,
              fontSizeFactor: 0.9, color: colorOnPColor, fontWeightDelta: 3),
        );
      },
    );
  }
}
