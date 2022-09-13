import 'package:customer_app/favorites/controllers/favorites_controller.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/products/product_details/screens/product_details.dart';
import 'package:customer_app/widgets/no_results.dart';
import 'package:customer_app/widgets/product_search_card.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class FavoritesProducts extends GetView<FavoritesController> {
  const FavoritesProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        ((state) => ListView.builder(
              controller: controller.scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) => ProductCardSearch(
                dismissible: true,
                product: state![index],
                onFavoriteTap: () {
                  // setState(() {
                  //   recipes[index]["is_favorited"] =
                  //       !recipes[index]["is_favorited"];
                  // });
                },
                onTap: () async {
                  controller.focusNode.unfocus();
                  await ProductDetails(
                    product: state[index],
                  ).launch(context,
                      duration: const Duration(milliseconds: 350),
                      pageRouteAnimation: PageRouteAnimation.Slide);
                },
              ),
              itemCount: state!.length,
            )),
        onEmpty: NoResults(
          scrollController: controller.scrollController,
          subTitle: 'No tienes productos favoritos',
        ));
  }
}
