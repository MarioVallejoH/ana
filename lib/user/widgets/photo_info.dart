import 'package:customer_app/register/widgets/image_pick.dart';
import 'package:customer_app/services/url_resources_service.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:customer_app/user/controllers/user_controller.dart';
import 'package:customer_app/utils/constant.dart';
import 'package:customer_app/widgets/custom_image.dart';
import 'package:customer_app/widgets/image_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class PhotoInfo extends GetView<UserController> {
  const PhotoInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.editUserData
          ? Column(
              children: [
                ImagePick(
                  isNetwork: true,
                  optionsAlignment: MainAxisAlignment.spaceEvenly,
                  height: 150,
                  width: double.infinity,
                  radius: radiusValue2,
                  imageUrl: UrlResourcesService.getImgUrl(
                      controller.userData?.companyData?.customerProfilePhoto ??
                          ''),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.userData?.companyData?.name ?? '',
                          style: ThemeConf().titleMediumTextStile(context,
                              fontWeightDelta: 2, fontSizeFactor: 1.2)),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'C.C  ',
                            style: ThemeConf()
                                .normalTextStyle(context, fontWeightDelta: 2)),
                        TextSpan(
                            text: controller.userData?.companyData?.vatNo ?? '',
                            style: ThemeConf().normalTextStyle(context)),
                      ]))
                    ],
                  ),
                )
              ],
            ).paddingSymmetric(horizontal: 8, vertical: 10)
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    ImagePreview(
                      imagePath: UrlResourcesService.getImgUrl(
                        controller
                                .userData?.companyData?.customerProfilePhoto ??
                            '',
                      ),
                      isNetworkImage: true,
                    ).launch(context);
                  },
                  child: ClipOval(
                    child: CustomImage(
                      UrlResourcesService.getImgUrl(controller
                              .userData?.companyData?.customerProfilePhoto ??
                          ''),

                      // 'assets/images/backgrounds/person.jpeg',
                      // isNetwork: false,
                      height: 80,
                      width: 80,
                      borderRadius: BorderRadius.circular(80),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.userData?.companyData?.name ?? '',
                          style: ThemeConf().titleMediumTextStile(context,
                              fontWeightDelta: 2, fontSizeFactor: 1.2)),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'C.C  ',
                            style: ThemeConf()
                                .normalTextStyle(context, fontWeightDelta: 2)),
                        TextSpan(
                            text: controller.userData?.companyData?.vatNo ?? '',
                            style: ThemeConf().normalTextStyle(context)),
                      ]))
                    ],
                  ),
                ).expand(),
              ],
            ).paddingSymmetric(horizontal: 16, vertical: 10);
    });
  }
}
