import 'package:customer_app/register/controller/register_controller.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'comp_reg_page2.dart';
import 'comp_reg_page3.dart';
import 'comp_reg_page4.dart';

class UserRegisterPages extends GetView<RegisterController> {
  UserRegisterPages({Key? key}) : super(key: key);

  final GlobalKey keyP1 = GlobalKey();
  final GlobalKey keyP2 = GlobalKey();

  final GlobalKey keyP3 = GlobalKey();
  final GlobalKey keyP4 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      dragStartBehavior: DragStartBehavior.down,
      scrollDirection: Axis.horizontal,
      children: [
        CompRegPage2(key: keyP2),
        CompRegPage3(key: keyP3),
        CompRegPage4(key: keyP4),
      ],
    );
  }
}
