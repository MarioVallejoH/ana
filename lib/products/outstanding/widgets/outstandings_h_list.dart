import 'package:customer_app/products/outstanding/controller/outstandings_controller.dart';
import 'package:customer_app/products/product_details/screens/product_details.dart';
import 'package:customer_app/products/products_related/products_related.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class OutstandingsHList extends GetView<OutstandingsController> {
  const OutstandingsHList({
    Key? key,
  }) : super(key: key);

  // bool _allLoaded = false;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.reloadOutstandings();
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            // padding: const EdgeInsets.only(left: 15),
            scrollDirection: Axis.horizontal,
            controller: controller.scrollControllerHWidget,
            child: controller.obx(
              (state) => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  state!.length,
                  (index) => ProductCardH(
                      product: state[index],
                      onTap: () async {
                        await ProductDetails(
                          product: state[index],
                        ).launch(context,
                            duration: const Duration(milliseconds: 350),
                            pageRouteAnimation: PageRouteAnimation.Slide);
                      }).paddingSymmetric(horizontal: 8),
                ),
              ),
            ),
          ),
          Obx(() {
            return controller.loading.value
                ? Loader().paddingSymmetric(vertical: 8)
                : Container();
          })
        ],
      ),
    );
  }
}
