import 'package:customer_app/cart/cart/controllers/cart_controller.dart';
import 'package:customer_app/cart/widgets/address_selected.dart';
import 'package:customer_app/cart/widgets/paymethod_selected.dart';
import 'package:customer_app/cart/widgets/total_info.dart';
import 'package:customer_app/widgets/custom_round_text_form.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:nb_utils/nb_utils.dart';

class OrderPayAndOther extends GetView<CartController> {
  const OrderPayAndOther({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.orderDetailsFormKey,
        child: Column(
          children: [
            const AddressSelected()
                .paddingSymmetric(horizontal: 7, vertical: 4),
            
            
            const PayMethodSelected()
                .paddingSymmetric(horizontal: 10, vertical: 4),
            const TotalInfo().paddingSymmetric(horizontal: 10, vertical: 4),
            CustomRoundTextForm(
              maxLenght: 300,
              maxLines: 3,
              labelText: 'Añade un comentario',
              controller: controller.commentTextController,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ).paddingSymmetric(horizontal: 10, vertical: 4)
          ],
        ),
      ),
    );
  }

  // Widget _deliveryTimePicker() {
  //   return Obx(() {
  //     // return SingleChildScrollView(
  //     //   child: Row(
  //     //     children: _dateOptions(controller.deliveryDate!),
  //     //   ),
  //     // );
  //     return DropdownSearch<DeliveryTime>(
  //       popupProps: PopupProps.menu(
  //           // searchFieldProps: TextFieldProps(
  //           //     decoration: InputDecoration(
  //           //         contentPadding: const EdgeInsets.symmetric(horizontal: 16),
  //           //         fillColor: greyLight,
  //           //         filled: true,
  //           //         hintText: "Buscar",
  //           //         border: OutlineInputBorder(
  //           //             borderRadius: BorderRadius.circular(radiusValue),
  //           //             borderSide: BorderSide.none))),
  //           menuProps: MenuProps(
  //               borderRadius: BorderRadius.circular(radiusValue), elevation: 5),
  //           showSelectedItems: true,
  //           emptyBuilder: (context, String? string) {
  //             return const Center(
  //               child: Text("No se encontraron franjas horarias disponibles"),
  //             );
  //           },
  //           fit: FlexFit.loose,
  //           showSearchBox: false),
  //       compareFn: (i1, i2) => i1.id == i2.id,
  //       // dropdownButtonProps: DropdownButtonProps(
  //       //   visualDensity: VisualDensity.compact
  //       // ),
  //       dropdownDecoratorProps: DropDownDecoratorProps(
  //           dropdownSearchDecoration: InputDecoration(
  //               // labelText: "Sucursales",
  //               contentPadding: const EdgeInsets.symmetric(horizontal: 8),
  //               prefixIcon: const Icon(
  //                 Icons.av_timer_sharp,
  //                 size: 18,
  //               ),
  //               fillColor: Colors.white,
  //               filled: true,
  //               isDense: true,
  //               labelText: "Franja horaria",
  //               // constraints: BoxConstraints.expand(height: 45),
  //               border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(radiusValue2),
  //                   // gapPadding: 10,
  //                   borderSide: BorderSide.none))),
  //       selectedItem: controller.deliveryTime,
  //       // asyncItems: (String? filter) async {
  //       //   return await DeliveryTimeProvider.getAvaibleDelivTimes();
  //       // },
  //       items: controller.deliveryTimes,
  //       validator: (value) {
  //         if (value == null) {
  //           return "Campo requerido";
  //         }
  //         return null;
  //       },
  //       onChanged: (DeliveryTime? value) {
  //         controller.setDeliveryTime(value);
  //       },
  //     );
  //   });
  // }
}
