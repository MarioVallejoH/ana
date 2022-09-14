
import 'package:customer_app/orders/orders_list/controllers/orders_list_controller.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/utils/constant.dart';
import 'package:customer_app/utils/formating/date_to_text.dart';
import 'package:customer_app/utils/formating/order_status_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../models/order_model.dart';
import '../../../theme/color.dart';

class OrderCard extends GetView<OrdersListController> {
  const OrderCard({Key? key, required this.orderModel}) : super(key: key);

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    final orderStratus = mapStatusText(orderModel.saleStatus);
    final statusColors = mapStatusColor(orderModel.saleStatus);
    return GestureDetector(
      onTap: () async {
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(parseDateStrES(
                  orderModel.registrationDate ?? orderModel.date ?? ''))
              .paddingOnly(left: 16, right: 16, top: 8),
          Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radiusValue2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${orderModel.id}',
                      style: ThemeConf().buttonsSmallTextStyle(
                        context,
                      ),
                      maxLines: 2,
                    ).paddingOnly(bottom: 6, left: 16, right: 16, top: 2),
                    AppButton(
                        onTap: () async {
                        },
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        margin: const EdgeInsets.only(right: 8, bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Ver detalle',
                              style: ThemeConf().normalTextStyle(context,
                                  color: primary, fontSizeFactor: 0.95),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                              color: primary,
                            )
                          ],
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Estado",
                              style: ThemeConf().normalTextStyle(context),
                              maxLines: 2,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(radiusValue2),
                                  color: statusColors['background']),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                orderStratus,
                                style: ThemeConf().normalTextStyle(context,
                                    color: statusColors['text']),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Numero de items",
                              style: ThemeConf().normalTextStyle(context),
                              maxLines: 2,
                            ),
                            Text(
                              orderModel.totalItems.toString(),
                              style: ThemeConf()
                                  .numbersTextStyle(fontSizeFactor: 0.85),
                              maxLines: 2,
                            ).paddingOnly(right: 4),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Forma de pago",
                              style: ThemeConf().normalTextStyle(context),
                              maxLines: 2,
                            ),
                            Text(
                              orderModel.paymentMethod ?? "",
                              style: ThemeConf()
                                  .numbersTextStyle(fontSizeFactor: 0.85),
                              maxLines: 2,
                            ).paddingOnly(right: 4),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Valor total",
                              style: ThemeConf().normalTextStyle(context),
                              maxLines: 2,
                            ),
                            Text(
                              orderModel.formatedGrandTotal(),
                              style: ThemeConf()
                                  .numbersTextStyle(fontSizeFactor: 0.85),
                              maxLines: 2,
                            ).paddingOnly(right: 4),
                          ],
                        )
                      ],
                    ).paddingOnly(left: 16, right: 14).expand(),
                  ],
                )
              ],
            ).paddingSymmetric(vertical: 6),
          ),
        ],
      ),
    );
  }

}
