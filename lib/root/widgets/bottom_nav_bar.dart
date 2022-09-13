import 'package:customer_app/cart/widgets/cart_status_nav_bar.dart';
import 'package:customer_app/root/controllers/root_controller.dart';
import 'package:customer_app/theme/color.dart';
import 'package:customer_app/root/widgets/bottombar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class BottomNavBar extends GetView<RootController> {
  const BottomNavBar(
      {Key? key, required this.showDrawer, required this.barItems})
      : super(key: key);
  final void Function() showDrawer;
  final List<Map> barItems;
  // final void Function(int) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // onPageChanged(controller.activeTabIndex);
      return AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        // offstage: !_isBottomVisible,
        curve: Curves.fastOutSlowIn,
        height: controller.isBottomVisible ? 75 : 0,

        width: double.infinity,
        decoration: BoxDecoration(
            color: bottomBarColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: shadowColor.withOpacity(0.1),
                blurRadius: 1,
                spreadRadius: 1,
                offset: const Offset(0, 1),
              )
            ]),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 45, right: 45, bottom: 10, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              barItems.length,
              (index) => AppButton(
                padding: EdgeInsets.zero,
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                elevation: 0,
                width: 10,
                onTap: () {},
                child: barItems[index]["cart"] ?? false
                    ? CartNavbarItem(
                        barItems[index]["icon"],
                        isActive: controller.activeTabIndex == index,
                        activeColor: primary,
                        color: colorOnPColor,
                        onTap: () {
                          if (barItems[index]["hide_bottom"] ?? false) {
                            controller.hideBottom();
                          }
                          if (barItems[index]["drawer"] ?? false) {
                            showDrawer();
                          } else {
                            if (index == controller.activeTabIndex) return;
                            controller.activeTabIndex = index;
                            controller.animationController.reset();
                            controller.activeTabIndex = index;
                            controller.animationController.forward();
                          }
                        },
                      )
                    : BottomBarItem(
                        barItems[index]["icon"],
                        withBadge: barItems[index]["badge"] ?? false,
                        badgeValue: barItems[index]["badge_value"],
                        isActive: controller.activeTabIndex == index,
                        activeColor: primary,
                        color: colorOnPColor,
                        onTap: () {
                          if (barItems[index]["hide_bottom"] ?? false) {
                            controller.hideBottom();
                          }
                          if (barItems[index]["drawer"] ?? false) {
                            showDrawer();
                          } else {
                            if (index == controller.activeTabIndex) return;
                            controller.activeTabIndex = index;
                            controller.animationController.reset();
                            controller.activeTabIndex = index;
                            controller.animationController.forward();
                          }
                        },
                      ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
