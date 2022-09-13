import 'package:customer_app/favorites/controllers/favorites_controller.dart';
import 'package:customer_app/favorites/widgets/favorites_categories_list.dart';
import 'package:customer_app/favorites/widgets/products_list.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/widgets/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:nb_utils/nb_utils.dart';
import '../../theme/color.dart';

import '../../widgets/custom_round_textbox.dart';
import '../../widgets/icon_box.dart';

class FavoritesScreen extends GetView<FavoritesController> {
  const FavoritesScreen({Key? key}) : super(key: key);

  // final double scrollDownTolerance = 30;

  // double dlt = 0

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: _buildBody(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(108 + (controller.showFilters ? 80 : 0)),
        child: SafeArea(
          child: buildOptionsBlock(context),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Obx(() => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: controller.showFilters ? 118 : 0,
              curve: Curves.decelerate,
              child: Card(
                  margin: EdgeInsets.zero,
                  child: FavoritesCategories()
                      .paddingSymmetric(horizontal: 10, vertical: 2),
                  elevation: controller.isAtTop ? 0 : 5,
                  shape: controller.showFilters
                      ? const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)))
                      : null),
            )),
        SizedBox(
          height: controller.showFilters ? 8 : 0,
        ),
        Stack(
          children: [
            RefreshIndicator(
              // triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: () async {
                await controller.search(refresh: true, fromOnRefresh: true);
              },
              child: const FavoritesProducts(),
            ),
            Obx(() {
              if (controller.loading) {
                return Loader();
              }
              return Container();
            })
          ],
        ).expand(),
      ],
    );
  }

  Widget buildOptionsBlock(BuildContext context) {
    return Obx(() => Card(
          margin: EdgeInsets.zero,
          elevation: controller.isAtTop ? 0 : (controller.showFilters ? 0 : 5),
          shape: !controller.showFilters
              ? const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)))
              : null,
          child: Container(
            padding: ThemeConf.appBarSPadding,
            height: 108,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBarTitle(
                  title: 'Favoritos',
                  fontWeightDelta: 2,
                ),
                Row(
                  children: [
                    CustomRoundTextBox(
                      hint: "Buscar",
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 3),
                      prefix: const Icon(Icons.search, color: Colors.grey),
                      suffix: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () async {
                          controller.queryController.clear();
                          controller.search(refresh: true);
                        },
                      ),
                      focus: controller.focusNode,
                      controller: controller.queryController,
                      onChanged: (String? value) async {
                        // controller.currentQuery = (value ?? '');
                        if (value != null) {
                          controller.scrollUp();
                          await controller.search(refresh: true);
                        }
                      },
                    ).expand(),
                    _filterSettings(),
                  ],
                ).expand(),
              ],
            ),
          ),
        ));
  }

  Widget _filterSettings() {
    return Obx(() {
      return AppButton(
        onTap: () {
          controller.showFilters = !controller.showFilters;
        },
        padding: EdgeInsets.zero,
        width: 0,
        shapeBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: IconBox(
          bgColor: !controller.showFilters ? Colors.white : primary,
          child: SvgPicture.asset(
            "assets/icons/filter1.svg",
            color: controller.showFilters ? Colors.white : primary,
            // width: 18,
            height: 18,
          ),
          radius: 50,
          padding: 8,
        ),
      );
    }).paddingLeft(10);
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "Explore",
          style: TextStyle(
            fontSize: 28,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
