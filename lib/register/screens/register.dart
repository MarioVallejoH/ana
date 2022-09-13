import 'package:customer_app/register/controller/register_controller.dart';
import 'package:customer_app/register/widgets/user_register_pages.dart';
import 'package:customer_app/theme/color.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class UserRegister extends GetView<RegisterController> {
  const UserRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appBar(context),
          _pageView(context),
        ],
      ),
    );
  }

  SliverFillRemaining _pageView(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        children: [
          UserRegisterPages().expand(),
          Obx(() {
            return Row(
              children: [
                AppButton(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  onTap: () {
                    if (controller.canBack) {
                      _goToPreviusPage();
                    }
                  },
                  enabled: controller.canBack,
                  elevation: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 40,
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 16, right: 8),
                    decoration: BoxDecoration(
                        color: controller.canBack ? primary : greyColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(radiusValue),
                            bottomLeft: Radius.circular(radiusValue))),
                    alignment: Alignment.center,
                    child: Text(
                      'Anterior',
                      style: ThemeConf()
                          .normalTextStyle(context, color: colorOnPColor),
                    ).paddingRight(4),
                  ),
                ).flexible(flex: 1),
                AppButton(
                  onTap: () async {
                    controller.isLoading = true;

                    try {
                      await controller.currentPageValidation(context);
                    } catch (e) {
                      log(e);
                    }
                    controller.isLoading = false;
                  },
                  // enabled: !controller.loading,
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    margin: const EdgeInsets.only(right: 16, left: 8),
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(radiusValue),
                            bottomRight: Radius.circular(radiusValue))),
                    alignment: Alignment.center,
                    child: controller.loading
                        ? SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: colorOnPColor,
                            ),
                          )
                        : Text(
                            'Siguiente',
                            style: ThemeConf()
                                .normalTextStyle(context, color: colorOnPColor),
                          ).paddingRight(4),
                  ),
                ).flexible(flex: 1),
              ],
            ).paddingSymmetric(vertical: 6);
          })
        ],
      ),
    );
  }

  SliverAppBar _appBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: appBarColor,
      pinned: true,
      floating: true,
      elevation: 10,
      leading: IconButton(
        onPressed: () {
          if (controller.pageController.page == 0) {
            finish(context);
          } else {
            _goToPreviusPage();
          }
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        color: mainColor,
      ),
      title: Text(
        'Empresa',
        style: ThemeConf().normalTextStyle(context),
      ),
      centerTitle: true,
    );
  }

  void _goToPreviusPage() {
    int page = (controller.pageController.page ?? 1).toInt() - 1;
    controller.pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}
