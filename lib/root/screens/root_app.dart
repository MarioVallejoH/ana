import 'package:customer_app/cart/cart/screens/cart.dart';
import 'package:customer_app/favorites/screens/favorites_screen.dart';
import 'package:customer_app/root/controllers/root_controller.dart';
import 'package:customer_app/root/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
// import 'package:customer_app/screens/cart/cart.dart';
import 'package:customer_app/explore/screens/explore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../theme/color.dart';
import '../widgets/user_drawer.dart';
import '../../home/screens/home.dart';

class RootApp extends GetView<RootController> {
  RootApp({Key? key}) : super(key: key);

  final List<Map> barItems = [
    {
      "icon": "assets/icons/home.svg",
      "page": const HomePage(),
    },
    {
      "icon": "assets/icons/search.svg",
      "page": const ExplorePage(),
    },
    {
      "icon": "assets/icons/heart.svg",
      "page": const FavoritesScreen(),
      // "hide_bottom": true
    },
    {
      "icon": "assets/icons/cart.svg",
      "page": Cart(),
      "cart":true
      // "hide_bottom": true,

    },
    {
      "icon": "assets/icons/avatar.svg",
      "drawer": true,
      "page": Container(),
    },
  ];

  late final Animation<double> _animation = CurvedAnimation(
    parent: controller.animationController,
    curve: Curves.fastOutSlowIn,
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  animatedPage(page) {
    return FadeTransition(child: page, opacity: _animation);
  }

//====== end set animation=====
  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (now.difference(controller.currentBackPressTime) >
            const Duration(seconds: 2)) {
      controller.currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Presione de nuevo para salir");
      return Future.value(false);
    }
    SystemNavigator.pop();
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: appBgColor,
        drawer: const UserDrawer(),
        bottomNavigationBar: buildBottomBar(),
        body: buildBottomBarPage(),
      ),
    );
  }

  Widget buildBottomBarPage() {
    return Obx(() {
      return IndexedStack(
          index: controller.activeTabIndex,
          children: List.generate(barItems.length,
              (index) => animatedPage(barItems[index]["page"])));
    });
  }

  Widget buildBottomBar() {
    return BottomNavBar(
      barItems: barItems,
      showDrawer: () {
        _scaffoldKey.currentState?.openDrawer();
      },
    );
    // return AnimatedContainer(
    //   duration: const Duration(milliseconds: 700),
    //   // offstage: !_isBottomVisible,
    //   curve: Curves.fastOutSlowIn,
    //   height: _isBottomVisible ? 75 : 0,

    //   width: double.infinity,
    //   decoration: BoxDecoration(
    //       color: bottomBarColor,
    //       borderRadius: const BorderRadius.only(
    //           topLeft: Radius.circular(25), topRight: Radius.circular(25)),
    //       boxShadow: [
    //         BoxShadow(
    //           color: shadowColor.withOpacity(0.1),
    //           blurRadius: 1,
    //           spreadRadius: 1,
    //           offset: const Offset(0, 1),
    //         )
    //       ]),
    //   child: Padding(
    //     padding: const EdgeInsets.only(left: 45, right: 45, bottom: 10, top: 5),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: List.generate(
    //         barItems.length,
    //         (index) => AppButton(
    //           padding: EdgeInsets.zero,
    //           shapeBorder: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(25)),
    //           elevation: 0,
    //           width: 10,
    //           onTap: () {},
    //           child: BottomBarItem(
    //             barItems[index]["icon"],
    //             withBadge: barItems[index]["badge"] ?? false,
    //             badgeValue: barItems[index]["badge_value"],
    //             isActive: activeTabIndex == index,
    //             activeColor: primary,
    //             onTap: () {
    //               if (barItems[index]["hide_bottom"] ?? false) {
    //                 hideBottom();
    //               }
    //               if (barItems[index]["drawer"] ?? false) {
    //                 _scaffoldKey.currentState?.openDrawer();
    //               } else {
    //                 onPageChanged(index);
    //               }
    //             },
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  void hideBottom() {
    controller.isBottomVisible = false;
  }

  void showBottom() {
    controller.isBottomVisible = true;
  }
}
