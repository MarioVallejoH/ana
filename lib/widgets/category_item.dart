import 'package:customer_app/services/url_resources_service.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/utils/formating/data_formating.dart';
import 'package:customer_app/widgets/custom_image.dart';
import '../products/models/product_category_model.dart';
import '../theme/color.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.category,
    this.isSelected = false,
    this.onTap,
    this.small = false,
    this.bgColor,
    this.padding = const EdgeInsets.fromLTRB(10, 8, 10, 8),
  }) : super(key: key);
  final ProductCategoryModel category;
  final bool isSelected;
  final Color? bgColor;
  final bool small;
  final GestureTapCallback? onTap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(radiusValue2),
          border: isSelected ? Border.all(color: primary, width: 1) : null,
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: shadowColor.withOpacity(0.07),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1), // changes position of shadow
              ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImage(
              (category.image != null || (category.image?.isEmpty ?? false))
                  ? UrlResourcesService.getImgUrl(category.image ?? "")
                  : "assets/images/category/salad.png",
              width: 50,
              height: 50,
              radius: 5,
              isNetwork:
                  (category.image != null || (category.image?.isEmpty ?? false))
                      ? true
                      : false,
              trBackground: true,
              isShadow: false,
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              alignment: Alignment.center,
              width: small ? 85 : 100,
              child: Text(
                capitalizeText(category.name),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: ThemeConf().normalTextStyle(
                  context,
                  fontSizeFactor: small ? 0.9 : 1.0,
                  color: fontTextColor,
                  fontWeightDelta: 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
