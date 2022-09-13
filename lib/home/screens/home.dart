import 'dart:convert';

import 'package:customer_app/cart/widgets/cart_status.dart';
import 'package:customer_app/explore/controllers/explore_controller.dart';
import 'package:customer_app/products/outstanding/screen/outstandings_screen.dart';
import 'package:customer_app/products/outstanding/widgets/outstandings_h_list.dart';
import 'package:customer_app/home/services/home_data_service.dart';
import 'package:customer_app/home/widgets/current_user_dir.dart';
import 'package:customer_app/home/widgets/hello_user.dart';
import 'package:customer_app/root/controllers/root_controller.dart';
import 'package:customer_app/routes/controllers/app_settings_controller.dart';
import 'package:customer_app/services/url_resources_service.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/utils/constant.dart';
import 'package:customer_app/widgets/custom_image.dart';
import 'package:flutter/material.dart';

import 'package:customer_app/widgets/custom_round_textbox.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
// import 'package:nb_utils/nb_utils.dart';

import '../../theme/color.dart';
// import '../utils/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<NestedScrollViewState> _globalKey = GlobalKey();

  final _categoryKey = UniqueKey();

  // bool _isAtTop = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});

    /// load user selected or default address
    HomeDataService.loadUserSelectedAddress();
    // _bestSellerController.addListener(infinityScrollListenerHorizontal());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: NestedScrollView(
        key: _globalKey,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            _sliverAppBar(innerBoxIsScrolled),
          ];
        },
        body: buildBody(),
      ),
    );
  }

  SliverAppBar _sliverAppBar(bool innerBoxIsScrolled) {
    return SliverAppBar(
      // foregroundColor: Colors.black,
      // backgroundColor: barMenuColor,
      backgroundColor: primary,
      title: _title().paddingTop(10),
      pinned: true,
      floating: true,
      automaticallyImplyLeading: false,
      expandedHeight: 108,
      forceElevated: innerBoxIsScrolled,
      // shape: const ContinuousRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //         bottomLeft: Radius.circular(30),
      //         bottomRight: Radius.circular(30))),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: buildOptionsBlock(innerBoxIsScrolled),
      ),
      // controller: _tabController,
    );
  }

  Widget _title() {
    String icon = "assets/icons/shopping-cart.svg";
    return Row(
      children: [
        const CurrentUserDir().expand(),
        const SizedBox(
          width: 20,
        ),
        CartStatusIcon(icon: icon, context: context).paddingRight(5)
      ],
    );
  }

  Widget buildOptionsBlock(bool isAtTop) {
    double topPadding = !isAtTop ? 10 : 20;
    double bottomPadding = !isAtTop ? 10 : 15;
    return Padding(
      padding: EdgeInsets.fromLTRB(24, topPadding, 24, bottomPadding),
      child: Row(
        children: [
          CustomRoundTextBox(
            hint: "Buscar",
            prefix: const Icon(Icons.search, color: Colors.grey),
            contentPadding: const EdgeInsets.only(top: 3, bottom: 3),
            readOnly: true,
            onTap: () async {
              Get.find<RootController>().activeTabIndex = 1;

              await Future.delayed(const Duration(milliseconds: 100));
              Get.find<ExploreController>().focusNode.requestFocus();
              // UiControllService.openExploreSearchField();
            },
          ).expand(),
        ],
      ),
    );
  }

  Widget buildSizedBox(double size, Color color) {
    return Container(
      height: size,
      width: size,
      color: color,
    );
  }

  Widget buildBody() {
    Map? temporal;
    try {
      temporal =
          jsonDecode(Get.find<AppSettingsController>().state?.slider ?? '');
    } catch (e) {
      log(e);
    }
    final size = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: () async {
        // await ProductsDataService().reloadBestSellers();
        // await ProductsDataService().reloadOutstandings();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(
            //   height: 15,
            // ),
            const HelloUser()
                .paddingOnly(left: 16, right: 16, top: 16, bottom: 8),
            // const SizedBox(
            //   height: 15,
            // ),
                        Row(
              children: [
                Text(
                  "Destacados",
                  style: ThemeConf()
                      .titleMediumTextStile(context, fontWeightDelta: 2),
                ).expand(),
                AppButton(
                  elevation: 0,
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(2),
                  onTap: () async {
                    // const OutstandingsScreen().launch(context);
                    showBottomSheet(
                      enableDrag: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return const OutstandingsScreen();
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        "Ver todos",
                        style: ThemeConf().titleMediumTextStile(context,
                            color: primary, fontSizeFactor: 1.0),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: primary,
                        size: 18,
                      ),
                    ],
                  ),
                )
              ],
            ).paddingSymmetric(horizontal: 16, vertical: 2),

            buildRecommend(),
            
          ],
        ),
      ),
    );
  }

  int selectedCategoryIndex = 0;



  Widget buildRecommend() {
    return const OutstandingsHList();
  }

  // Widget buildAppbar() {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       SizedBox(
  //         width: 34,
  //         height: 34,
  //         child: IconBox(
  //           child: SvgPicture.asset("assets/icons/menu1.svg"),
  //           radius: 15,
  //           bgColor: appBgColor,
  //         ),
  //       ),
  //       const NotificationBox(
  //         notifiedNumber: 1,
  //       ),
  //     ],
  //   );
  // }

}
