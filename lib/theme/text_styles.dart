// import 'package:customer_app/routes/controllers/app_settings_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:customer_app/theme/color.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// OutlineInputBorder outlineFocusedInputBorder() {
//   return OutlineInputBorder(
//     borderRadius: BorderRadius.circular(5.0),
//     borderSide: BorderSide(color: primary),
//   );
// }

// TextStyle ThemeConf().buttonsTextStyle(BuildContext context,
//     {fontSizeFactor = 1.2, fontWeightDelta = 1, color = Colors.white}) {
//   final fontSelected = Get.find<AppSettingsController>().state?.fontFamily;

//   if (fontSelected == 'Verdana') {
//     return TextStyle(
//       fontFamily: fontSelected,
//       fontSize: 18,
//       color: color,
//       fontWeight: FontWeight.normal,
//     ).apply(fontWeightDelta: fontWeightDelta);
//   }
//   return Theme.of(context).primaryTextTheme.headline6!.apply(
//       fontSizeFactor: fontSizeFactor,
//       color: color,
//       fontWeightDelta: fontWeightDelta);
// }

// TextStyle ThemeConf().buttonsSmallTextStyle(BuildContext context,
//     {double fontSizeFactor = 0.95, Color? color, int fontWeightDelta = 1}) {
//   final fontSelected = Get.find<AppSettingsController>().state?.fontFamily;
//   if (fontSelected == 'Verdana') {
//     return TextStyle(
//       fontFamily: 'Verdana',
//       fontSize: 15,
//       color: color,
//       fontWeight: FontWeight.normal,
//     ).apply(fontWeightDelta: fontWeightDelta);
//   }
//   return Theme.of(context).primaryTextTheme.headline6!.apply(
//       fontSizeFactor: fontSizeFactor,
//       color: color ?? greyDarkerColor,
//       fontWeightDelta: fontWeightDelta);
// }

// TextStyle appBarTextStyle({double fontSizeFactor = 1, Color? color}) {
//   final fontSelected = Get.find<AppSettingsController>().state?.fontFamily;
//   if (fontSelected == 'Verdana') {
//     return TextStyle(
//       fontFamily: 'Verdana',
//       fontSize: fontSizeFactor,
//       color: color,
//       fontWeight: FontWeight.normal,
//     );
//   }
//   return TextStyle(
//       fontWeight: FontWeight.w600,
//       fontSize: 20 * fontSizeFactor,
//       color: color ?? greyDarkerColor);
// }

// TextStyle ThemeConf().normalTextStyle(BuildContext context,
//     {fontSizeFactor = 1.0, int fontWeightDelta = 0, Color? color}) {
//   final fontSelected = Get.find<AppSettingsController>().state?.fontFamily;

//   if (fontSelected == 'Verdana') {
//     return TextStyle(
//       fontFamily: fontSelected,
//       fontSize: 15,
//       color: color ?? greyDarkerColor,
//       fontWeight: FontWeight.w100,
//     ).apply(fontWeightDelta: fontWeightDelta, fontSizeFactor: fontSizeFactor);
//   }
//   return Theme.of(context).textTheme.subtitle1!.apply(
//       fontSizeFactor: fontSizeFactor,
//       color: color ?? greyDarkerColor,
//       fontWeightDelta: fontWeightDelta);
// }

// TextStyle ThemeConf().titleMediumTextStile(BuildContext context,
//     {fontSizeFactor = 1.1, int fontWeightDelta = 0, Color? color}) {
//   final fontSelected = Get.find<AppSettingsController>().state?.fontFamily;
//   if (fontSelected == 'Verdana') {
//     return TextStyle(
//       fontFamily: 'Verdana',
//       fontSize: 16,
//       color: color ?? greyDarkerColor,
//       fontWeight: FontWeight.normal,
//     ).apply(fontWeightDelta: fontWeightDelta, fontSizeFactor: fontSizeFactor);
//   }
//   return Theme.of(context).textTheme.titleMedium!.apply(
//       fontSizeFactor: fontSizeFactor,
//       color: color ?? greyColor,
//       fontWeightDelta: fontWeightDelta);
// }

// TextStyle ThemeConf().titleTextStile(BuildContext context,
//     {fontSizeFactor = 1.1, int fontWeightDelta = 1, Color? color}) {
//   final fontSelected = Get.find<AppSettingsController>().state?.fontFamily;
//   if (fontSelected == 'Verdana') {
//     return TextStyle(
//       fontFamily: 'Verdana',
//       fontSize: 18,
//       color: color ?? greyDarkerColor,
//       fontWeight: FontWeight.normal,
//     ).apply(fontWeightDelta: fontWeightDelta, fontSizeFactor: fontSizeFactor);
//   }
//   return Theme.of(context).textTheme.titleLarge!.apply(
//       fontSizeFactor: fontSizeFactor,
//       color: color ?? greyDarkerColor,
//       fontWeightDelta: fontWeightDelta);
// }

// TextStyle smallTextStyle(BuildContext context,
//     {fontSizeFactor = 1.0, int fontWeightDelta = 0, Color? color}) {
//   final fontSelected = Get.find<AppSettingsController>().state?.fontFamily;
//   if (fontSelected == 'Verdana') {
//     return TextStyle(
//       fontFamily: 'Verdana',
//       fontSize: 12,
//       color: color ?? greyDarkerColor,
//       fontWeight: FontWeight.normal,
//     ).apply(fontWeightDelta: fontWeightDelta, fontSizeFactor: fontSizeFactor);
//   }
//   return Theme.of(context).textTheme.caption!.apply(
//       fontSizeFactor: fontSizeFactor,
//       color: color ?? greyDarkerColor,
//       fontWeightDelta: fontWeightDelta);
// }

// TextStyle ThemeConf().numbersTextStyle(
//     {double fontSizeFactor = 0.9, fontWeight = FontWeight.w500, Color? color}) {
//   final fontSelected = Get.find<AppSettingsController>().state?.fontFamily;
//   if (fontSelected == 'Verdana') {
//     return TextStyle(
//       fontFamily: 'Verdana',
//       fontSize: 20,
//       color: color,
//       fontWeight: fontWeight,
//     ).apply(fontSizeFactor: fontSizeFactor);
//   }
//   return TextStyle(
//       fontFamily: 'Arial',
//       fontSize: 20 * fontSizeFactor,
//       fontWeight: fontWeight,
//       color: color ?? greyColor);
// }
