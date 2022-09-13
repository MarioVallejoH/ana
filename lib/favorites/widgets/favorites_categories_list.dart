import 'package:customer_app/favorites/controllers/favorites_controller.dart';
import 'package:customer_app/products/products_related/products_related.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/categories_skeleton.dart';
import '../../widgets/category_item.dart';

class FavoritesCategories extends GetView<FavoritesController> {
  FavoritesCategories({
    Key? key,
  }) : super(key: key);
  final productsRelatedController = Get.find<ProductsRelatedController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categorías',
          style: ThemeConf().normalTextStyle(context),
        ).paddingOnly(left: 8),
        SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(7, 5, 7, 5),
            scrollDirection: Axis.horizontal,
            child: productsRelatedController.obx(
                (state) => Row(
                      children: List.generate(
                          productsRelatedController.pCategories.length,
                          (index) {
                        ValueNotifier<bool> isSelected = ValueNotifier(
                            controller.isCategorySelected(
                                productsRelatedController.pCategories[index]));
                        return productsRelatedController
                                    .pCategories[index].hide ==
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
                                          controller.removeCategory(
                                              productsRelatedController
                                                  .pCategories[index]);
                                        } else {
                                          controller.selectCategory(
                                              productsRelatedController
                                                  .pCategories[index]);
                                        }
                                        isSelected.value =
                                            controller.isCategorySelected(
                                                productsRelatedController
                                                    .pCategories[index]);
                                        await controller.reloadFavorites();
                                      },
                                    ),
                                  );
                                },
                              );
                      }),
                    ),
                onEmpty: const CategoriesSkeleton())),
      ],
    );
  }
}
