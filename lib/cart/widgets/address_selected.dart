
import 'package:customer_app/widgets/address_card.dart';
import 'package:customer_app/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressSelected extends GetView<HomeController> {
  const AddressSelected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AddressCard(
        address: controller.selectedAddrss!,
        smallForm: true,
        onTap: () {
        },
      );
    });
  }
}
