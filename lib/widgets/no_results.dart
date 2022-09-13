import 'package:customer_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class NoResults extends StatelessWidget {
  final ScrollController? scrollController;
  NoResults({
    Key? key,
    this.title,
    this.subTitle,
    this.scrollController,
  }) : super(key: key);

  String? title;
  String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      // color: Colors.red,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ('assets/images/icons/no-results.png'),
              height: 70,
              width: 70,
            ).paddingBottom(10),
            Text(
              title ?? 'No encontramos productos',
              style: ThemeConf().normalTextStyle(context, fontWeightDelta: 2),
            ).paddingBottom(4),
            Text(subTitle ?? 'Revisa que tu búsqueda este bien escrita.'),
          ],
        ),
      ),
    );
  }
}
