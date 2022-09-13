import 'package:customer_app/explore/controllers/explore_controller.dart';
import 'package:customer_app/products/product_details/services/products_data_service.dart';
import 'package:customer_app/products/products.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/products/product_details/screens/product_details.dart';
import 'package:customer_app/widgets/no_results.dart';
import 'package:customer_app/widgets/product_search_card.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class SearchProductsList extends GetView<ExploreController> {
  SearchProductsList({
    Key? key,
  }) : super(key: key);

  final _productDataService = ProductsDataService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controller.exploreSearchStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>?> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return NoResults(scrollController: controller.scrollController);
          }
          return ListView.builder(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) => ProductCardSearch(
              product: snapshot.data![index],
              onFavoriteTap: () {
                // setState(() {
                //   recipes[index]["is_favorited"] =
                //       !recipes[index]["is_favorited"];
                // });
              },
              onTap: () async {
                controller.focusNode.unfocus();
                await ProductDetails(
                  product: snapshot.data![index],
                ).launch(context,
                    duration: const Duration(milliseconds: 350),
                    pageRouteAnimation: PageRouteAnimation.Slide);
              },
            ),
            itemCount: snapshot.data!.length,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
