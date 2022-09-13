import 'package:customer_app/explore/controllers/explore_controller.dart';
import 'package:customer_app/explore/widgets/explore_categories_list.dart';
import 'package:customer_app/explore/widgets/product_search_list.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/widgets/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:nb_utils/nb_utils.dart';
import '../../theme/color.dart';

import '../../widgets/custom_round_textbox.dart';
import '../../widgets/icon_box.dart';

class ExplorePage extends GetView<ExploreController> {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: _buildBody(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(108 + (controller.isAtTop ? 80 : 0)),
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
                  child: ExploreCategoriesList()
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
          height: controller.isAtTop | controller.showFilters ? 5 : 0,
        ),
        Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                await controller.search(
                    refresh: true, page: 0, fromOnRefresh: true);
              },
              child: SearchProductsList(),
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
          elevation: !controller.showFilters && !controller.isAtTop ? 5 : 0,
          shape: !controller.showFilters && !controller.isAtTop
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
                  title: 'Buscar productos',
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
                          controller.setExplorePage(page: 0);
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
