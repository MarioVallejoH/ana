import 'package:customer_app/explore/controllers/explore_controller.dart';
import 'package:customer_app/products/products_related/products_related.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/categories_skeleton.dart';
import '../../widgets/category_item.dart';

class ExploreCategoriesList extends GetView<ExploreController> {
  ExploreCategoriesList({
    Key? key,
  }) : super(key: key);
  final productsRelatedController = Get.find<ProductsRelatedController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(7, 5, 7, 5),
        scrollDirection: Axis.horizontal,
        child: productsRelatedController.obx(
            (state) => Row(
                  children: List.generate(
                      productsRelatedController.pCategories.length, (index) {
                    ValueNotifier<bool> isSelected = ValueNotifier(
                        controller.isCategorySelected(
                            productsRelatedController.pCategories[index]));
                    return productsRelatedController.pCategories[index].hide ==
                            1
                        ? Container()
                        : ValueListenableBuilder(
                            valueListenable: isSelected,
                            builder: (_, bool value, child) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: CategoryItem(
                                  small: true,
                                  category: productsRelatedController
                                      .pCategories[index],
                                  // isSelected: index == selectedCategoryIndex,
                                  isSelected: value,
                                  onTap: () async {
                                    if (controller.isCategorySelected(
                                        productsRelatedController
                                            .pCategories[index])) {
                                      controller.removeExploreCategory(
                                          productsRelatedController
                                              .pCategories[index]);
                                    } else {
                                      controller.selectExploreCategory(
                                          productsRelatedController
                                              .pCategories[index]);
                                    }
                                    isSelected.value =
                                        controller.isCategorySelected(
                                            productsRelatedController
                                                .pCategories[index]);
                                    await controller.reloadExploreSearch();
                                  },
                                ),
                              );
                            },
                          );
                  }),
                ),
            onEmpty: const CategoriesSkeleton()));
  }
}
