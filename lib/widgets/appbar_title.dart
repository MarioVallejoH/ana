import 'package:customer_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key, required this.title, this.fontWeightDelta = 0})
      : super(key: key);
  final String title;
  final int fontWeightDelta;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:
          ThemeConf().titleTextStileAppBar(context, fontWeightDelta: fontWeightDelta),
    ).paddingOnly(left: 4, bottom: 4);
  }
}
