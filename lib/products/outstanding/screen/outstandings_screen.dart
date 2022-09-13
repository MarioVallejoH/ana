import 'package:customer_app/products/outstanding/widgets/outstandings_v_list.dart';
import 'package:customer_app/theme/color.dart';
import 'package:customer_app/utils/constant.dart';
import 'package:customer_app/widgets/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class OutstandingsScreen extends StatelessWidget {
  const OutstandingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: size.height * 0.028),
      decoration:  BoxDecoration(
        color: appBgColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(radiusValue3),
          topRight: Radius.circular(radiusValue3),
        ),
      ),
      padding: const EdgeInsets.only(top: 10),
      child: Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(
            title: 'Destacados',
            fontWeightDelta: 2,
          ),
          centerTitle: false,
          elevation: 0.5,
          leading: IconButton(
            onPressed: () {
              finish(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: greyDarkerColor,
              size: 20,
            ),
          ),
          backgroundColor: appBgColor,
          actions: [
            IconButton(
              onPressed: () {
                // finish(context);
              },
              icon: Icon(
                Icons.search_rounded,
                size: 25,
                color: greyDarkerColor,
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 0.5),
          // alignment: Alignment.topCenter,
          decoration:  BoxDecoration(
            color: appBgColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(radiusValue2),
              topRight: Radius.circular(radiusValue2),
            ),
          ),
          child: const OutstandingsVList(),
        ),
      ),
    );
  }
}
