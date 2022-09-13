import 'package:customer_app/products/outstanding/controller/outstandings_controller.dart';
import 'package:customer_app/products/product_details/screens/product_details.dart';
import 'package:customer_app/widgets/product_search_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class OutstandingsVList extends GetView<OutstandingsController> {
  const OutstandingsVList({
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
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            // padding: const EdgeInsets.only(left: 15),
            scrollDirection: Axis.vertical,
            controller: controller.scrollController,
            child: controller.obx(
              (state) => Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  state!.length,
                  (index) => ProductCardSearch(
                      product: state[index],
                      onTap: () async {
                        await ProductDetails(
                          product: state[index],
                        ).launch(context,
                            duration: const Duration(milliseconds: 350),
                            pageRouteAnimation: PageRouteAnimation.Slide);
                      }),
                ),
              ),
            ),
          ),
          Obx(() {
            return controller.loading.value
                ? Positioned(
                    bottom: 0,
                    right: 1,
                    left: 1,
                    child: Loader().paddingSymmetric(vertical: 8))
                : Container();
          })
        ],
      ),
    );
  }
}
