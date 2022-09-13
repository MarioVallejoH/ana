import 'dart:io';

import 'package:customer_app/home/images/images.dart';
import 'package:customer_app/theme/color.dart';
import 'package:customer_app/utils/constant.dart';
import 'package:customer_app/widgets/custom_image.dart';
import 'package:customer_app/widgets/image_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class ImagePick extends GetView<ImageController> {
  const ImagePick(
      {Key? key,
      this.radius = radiusValue2,
      this.width = 110,
      this.isNetwork = false,
      this.height = 110,
      this.imageUrl = '',
      this.optionsAlignment = MainAxisAlignment.center})
      : super(key: key);
  final double radius;
  final double width;
  final double height;
  final MainAxisAlignment optionsAlignment;
  final bool isNetwork;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final t = controller.photo != null && (controller.photo?.path.isNotEmpty??false);
      return Stack(
        // fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: GestureDetector(
                onTap: () async {
                  if (!t) {
                    ImagePreview(
                      imagePath: imageUrl,
                      // isFileImage: !t,
                      isNetworkImage: true,
                    ).launch(context);
                  } else {
                    ImagePreview(
                      imagePath: controller.photo!.path,
                      isFileImage: true,
                    ).launch(context);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      color: greyMediumLight),
                  width: width,
                  height: height,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      t
                          ? Image.file(
                              File(controller.photo!.path),
                              fit: BoxFit.cover,
                              height: height,
                              width: width,
                            )
                          : isNetwork
                              ? CustomImage(
                                  imageUrl,
                                  isNetwork: true,
                                  width: width,
                                  radius: radius,
                                  height: height,
                                )
                              : Container(),
                      Container(
                        // margin: const EdgeInsets.only(top: 70),
                        padding: const EdgeInsets.only(bottom: 3),
                        width: width,
                        // height: (height / 2),

                        color: greyColor.withOpacity(0.4),
                        child: Row(
                          mainAxisAlignment: optionsAlignment,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await openCameraOrGallery(context, true);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 6, bottom: 6, right: 4),
                                child: const Icon(
                                  Icons.add_a_photo_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await openCameraOrGallery(context, false);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 6, bottom: 6, left: 4),
                                child: const Icon(
                                  Icons.add_photo_alternate_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          t
              ? Positioned(
                  top: -10,
                  right: -1,
                  child: IconButton(
                    onPressed: () {
                      controller.photo = XFile('');
                    },
                    icon: Image.asset('assets/images/icons/close.png'),
                  ))
              : Container()
        ],
      );
    });
  }
}
