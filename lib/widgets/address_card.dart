import 'package:customer_app/models/address_model.dart';
import 'package:customer_app/home/controllers/home_controller.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/utils/constant.dart';
// import 'package:customer_app/utils/formating/data_formating.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../theme/color.dart';

class AddressCard extends GetView<HomeController> {
  const AddressCard(
      {Key? key, required this.address, this.smallForm = false, this.onTap})
      : super(key: key);

  final AddressModel address;
  // final bool isSelected;
  final Function? onTap;
  final bool smallForm;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isSelected = controller.selectedAddrss?.id == address.id;

      return GestureDetector(
        onTap: () async {
          if (onTap != null) {
            onTap!();
          } else {
            await controller.setSelectedAddrss(address);
          }
        },
        child: AnimatedContainer(
          margin:
              EdgeInsets.symmetric(horizontal: 10, vertical: smallForm ? 2 : 6),
          padding: const EdgeInsets.symmetric(horizontal: 4),
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
          child: Row(
            children: [
              const Icon(Icons.location_on_outlined).paddingLeft(14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        address.sucursal ?? "",
                        style: ThemeConf()
                            .titleMediumTextStile(context, fontWeightDelta: 2),
                        maxLines: 2,
                      ),
                      const Icon(
                        Icons.more_vert_rounded,
                        size: 18,
                        color: labelColor,
                      )
                    ],
                  ).paddingOnly(bottom: smallForm ? 2 : 6, top: 2),
                  Text(
                    address.formatedDir(),
                    style: ThemeConf().normalTextStyle(
                      context,
                      color: greyColor,
                    ),
                    maxLines: 2,
                  ),
                  Text(
                    address.formatedCityState(),
                    style: ThemeConf().normalTextStyle(
                      context,
                      color: greyColor,
                    ),
                    maxLines: 2,
                  ),
                  smallForm
                      ? Container()
                      : Text(
                          address.formatedContact(),
                          style: ThemeConf().normalTextStyle(
                            context,
                            color: greyColor,
                          ),
                          maxLines: 2,
                        ),
                ],
              ).paddingSymmetric(horizontal: 16).expand(),
            ],
          ).paddingSymmetric(vertical: 10),
        ),
      );
    });
  }

  // Future<void> _addressDetails(BuildContext context) async {
  //   // await ChangeNotifierProvider(
  //   //                 create: (_) => AddressCreationProvider(),
  //   //                 child: const CreateAddress())
  //   //             .launch(context,
  //   //                 duration: const Duration(milliseconds: 300),
  //   //                 pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
  // }
}
