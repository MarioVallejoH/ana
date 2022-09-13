import 'package:customer_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/constant.dart';
import '../custom_image.dart';

class CustomSnackBarContent extends StatelessWidget {
  const CustomSnackBarContent(
      {Key? key,
      required this.title,
      this.subtitle = '',
      this.onlyTitle = false,
      this.assetImageDir,
      required this.bgColor})
      : super(key: key);

  final String title;
  final Color bgColor;
  final bool onlyTitle;
  final String? assetImageDir;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      },
      child: Container(
        height: onlyTitle ? 60 : 80,
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(radiusValue)),
        child: Row(
          children: [
            CustomImage(
              assetImageDir ?? 'assets/images/icons/error-m.png',
              isNetwork: false,
              height: 40,
              width: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 16),
              child: Column(
                mainAxisAlignment: onlyTitle
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: ThemeConf()
                        .titleMediumTextStile(context, color: Colors.white),
                  ).paddingOnly(top: onlyTitle ? 4 : 10, bottom: 4),
                  onlyTitle
                      ? Container()
                      : Text(
                          subtitle,
                          style: ThemeConf().normalTextStyle(context,
                              fontSizeFactor: 1.0, color: Colors.white),
                        ),
                ],
              ),
            ).expand(),
          ],
        ).paddingOnly(left: 16),
      ),
    );
  }
}
