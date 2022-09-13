import 'package:customer_app/orders/orders_list/widgets/orders_list.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../theme/color.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
        body: CustomScrollView(
      slivers: [
        _appBar(context),
        const SliverFillRemaining(
          child: OrdersList(),
        ),
      ],
    ));
  }

  SliverAppBar _appBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: appBarColor,
      pinned: true,
      floating: true,
      elevation: 10,
      leading: IconButton(
        onPressed: () {
          // Get.find<RootController>().activeTabIndex = 0;
          finish(context);
          // UiControllService.showBottomBar();
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        color: mainColor,
      ),
      automaticallyImplyLeading: false,
      title: Text(
        'Mis Pedidos',
        style: ThemeConf().normalTextStyle(context),
      ),
      centerTitle: true,
    );
  }
}
