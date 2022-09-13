import 'package:badges/badges.dart';
import 'package:customer_app/cart/cart/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../theme/color.dart';

class CartNavbarItem extends GetView<CartController> {
  const CartNavbarItem(this.icon,
      {Key? key,
      this.onTap,
      this.color = Colors.grey,
      this.activeColor,
      this.isActive = false})
      : super(key: key);
  final String icon;
  final Color color;
  final Color? activeColor;
  final bool isActive;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isActive ? primary : Colors.white,
          // color: widget.isActive ? primary : bottomBarColor,
          boxShadow: [
            if (isActive)
              BoxShadow(
                color: colorOnPColor,
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 0), // changes position of shadow
              ),
          ],
        ),
        child: controller.obx(
            (state) => Badge(
                  alignment: Alignment.topRight,
                  // padding: EdgeInsets.all(3),
                  position: BadgePosition.topEnd(),
                  // padding: const EdgeInsets.only(
                  //     right: 5, bottom: 1, top: 2, left: 2),
                  elevation: 0,
                  child: _icon(),
                  // badgeColor: widget.isActive ? primary : colorOnPColor,
                  badgeContent: Text(
                    state?.length.toString() ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
            onError: (e) => Text(e.toString()),
            onLoading: Loader()),
      ),
    );
  }

  SvgPicture _icon() {
    return SvgPicture.asset(
      icon,
      color: !isActive ? Colors.grey : color,
      width: 25,
      height: 25,
    );
  }
}
