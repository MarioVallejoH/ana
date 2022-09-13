import 'package:customer_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/constant.dart';
import '../custom_image.dart';

class SimpleSnackBar extends StatelessWidget {
  const SimpleSnackBar(
      {Key? key,
      required this.subtitle,
      this.assetImageDir = 'assets/images/icons/error-m.png',
      required this.bgColor})
      : super(key: key);

  final Color bgColor;
  final String assetImageDir;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(radiusValue)),
          child: Row(
            children: [
              CustomImage(
                assetImageDir,
                isNetwork: false,
                height: 40,
                width: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subtitle,
                      style: ThemeConf().normalTextStyle(context,
                          fontSizeFactor: 0.9, color: Colors.white),
                    ),
                  ],
                ),
              ).expand(),
            ],
          ).paddingOnly(left: 16),
        ),
        Positioned(
          right: 0,
          top: -18,
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            },
            child: const CustomImage(
              'assets/images/icons/close.png',
              bgColor: Colors.red,
              isNetwork: false,
              height: 40,
              width: 40,
            ),
          ),
        )
      ],
    );
  }
}
