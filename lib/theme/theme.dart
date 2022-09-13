import 'package:customer_app/routes/controllers/app_settings_controller.dart';
import 'package:customer_app/utils/color/from_hex_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConf {
  /// Appbar's padding (to appbar with title)
  static get appBarSPaddingWT => const EdgeInsets.fromLTRB(16, 18, 16, 5);

  /// Appbar's padding (to appbar without title)

  static get appBarSPadding => const EdgeInsets.fromLTRB(16, 20, 16, 10);

  Color get primary => HexColor.fromHex(
      Get.find<AppSettingsController>().state?.primaryColor ?? 'FF8800');
  Color get barMenuColor => HexColor.fromHex(
      Get.find<AppSettingsController>().state?.barMenuColor ?? 'FFFFFF');
  Color get secondaryColor => HexColor.fromHex(
      Get.find<AppSettingsController>().state?.secondaryColor ?? 'FF9747');
  Color get fontTextColor => HexColor.fromHex(
      Get.find<AppSettingsController>().state?.fontTextColor ?? '');
  Color get backgroundPageColor => HexColor.fromHex(
      Get.find<AppSettingsController>().state?.backgroundPageColor ?? 'FFFFFF');
  Color get headerColor => HexColor.fromHex(
      Get.find<AppSettingsController>().state?.headerColor ?? 'FFFFFF');
  Color get footerColor => HexColor.fromHex(
      Get.find<AppSettingsController>().state?.footerColor ?? 'FFFFFF');
  Color get navBarColor => HexColor.fromHex(
      Get.find<AppSettingsController>().state?.navbarColor ?? '');
  Color get navBarTextColor => HexColor.fromHex(
      Get.find<AppSettingsController>().state?.navbarTextColor ?? '616161');
  Color get barMenuTextColor => HexColor.fromHex(
      Get.find<AppSettingsController>().state?.barMenuTextColor ?? 'FFFFFF');
  Color get footerTextColor => HexColor.fromHex(
      Get.find<AppSettingsController>().state?.footerTextColor ?? '');
  Color get promotionTextColor => HexColor.fromHex(
      Get.find<AppSettingsController>().state?.promotionTextColor ?? '');
  Color get favoriteColor => HexColor.fromHex(
      Get.find<AppSettingsController>().state?.favoriteColor ?? '');
  static const secondary = Color(0xFFe96561);

  Color get colorOnPColor => barMenuTextColor;

  static const deleteColor = Colors.red;

  static const errorColor2 = Colors.red;

  static const okColorWappsi = Color.fromRGBO(0, 176, 82, 1);

  static const bottomBarIconsColor = Color.fromRGBO(247, 247, 247, 1);

  static const cartItemColor = Color.fromRGBO(247, 247, 247, 1);

  final skeletonShimerColor = Colors.grey[500];

  static const mainColor = Color(0xFF000000);
  static const darker = Color(0xFF3E4249);
  static const appBgColor = Color(0xFFF7F7F7);
  static const appBarColor = Color(0xFFF7F7F7);
  static const bottomBarColor = Colors.white;
  static const inActiveColor = Colors.grey;
  static const shadowColor = Colors.black87;
  static const textBoxColor = Colors.white;
  static const textColor = Color(0xFF333333);
  static const labelColor = Color(0xFF8A8989);

  static const actionColor = Color(0xFFe54140);
  static const buttonColor = Color(0xFFcdacf9);
  static const cardColor = Colors.white;

  static const yellow = Color(0xFFffcb66);
  static const green = Color(0xFFa2e1a6);
  static const pink = Color(0xFFf5bde8);
  static const purple = Color(0xFFcdacf9);
  static const red = Color(0xFFf77080);
  static const orange = Color(0xFFf5ba92);
  static const sky = Color(0xFFABDEE6);
  static const blue = Color(0xFF509BE4);
  static const cyan = Color(0xFF4ac2dc);
  static const darkerGreen = Color(0xFFb0d96d);

  /// Color to subtitles
  static Color get greyColor => const Color.fromARGB(255, 69, 69, 69);

  static Color greyLight = Colors.grey[100]!;

  static Color greyDarkerLight = Colors.grey[200]!;

  static Color greyMediumLight = Colors.grey[300]!;

  static Color greyDLight = Colors.grey[400]!;

  /// Color darker to subtitles
  static Color greyDarkerColor = Colors.grey[800]!;

  /// TextStyles
  ///
  ///

  OutlineInputBorder outlineFocusedInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(color: primary),
    );
  }

  TextStyle _getTextStyle(BuildContext context, fontSizeFactor, Color? color,
      fontWeightDelta, double fontSize) {
    final fontSelected = Get.find<AppSettingsController>().state?.fontFamily;

    TextStyle? textStyle = Theme.of(context).primaryTextTheme.headline6!.apply(
        fontSizeFactor: fontSizeFactor,
        color: color ?? greyColor,
        fontWeightDelta: fontWeightDelta);

    if (fontSelected == 'Verdana') {
      textStyle = TextStyle(
        fontFamily: fontSelected,
        fontSize: fontSize,
        color: color ?? greyColor,
        fontWeight: FontWeight.normal,
      );
    } else if (fontSelected == 'Roboto') {
      textStyle = GoogleFonts.roboto(
        fontSize: fontSize,
        color: color ?? greyColor,
        fontWeight: FontWeight.normal,
      );
    } else if (fontSelected == 'Times') {
      textStyle = TextStyle(
        fontFamily: fontSelected,
        fontSize: fontSize,
        color: color ?? greyColor,
        fontWeight: FontWeight.normal,
      );
    } else if (fontSelected == 'Poppins') {
      textStyle = GoogleFonts.poppins(
        fontSize: fontSize,
        color: color ?? greyColor,
        fontWeight: FontWeight.normal,
      );
    }
    return textStyle.apply(
        fontWeightDelta: fontWeightDelta, fontSizeFactor: fontSizeFactor);
  }

  TextStyle buttonsTextStyle(BuildContext context,
      {fontSizeFactor = 1.2, fontWeightDelta = 1, Color? color}) {
    double fontSize = 18;

    return _getTextStyle(
        context, fontSizeFactor, color, fontWeightDelta, fontSize);
  }

  TextStyle normalTextStyle(BuildContext context,
      {fontSizeFactor = 1.2, fontWeightDelta = 1, Color? color}) {
    double fontSize = 14;

    return _getTextStyle(
        context, fontSizeFactor, color, fontWeightDelta, fontSize);
  }

  TextStyle buttonsSmallTextStyle(BuildContext context,
      {fontSizeFactor = 1.2, fontWeightDelta = 1, Color? color}) {
    double fontSize = 15;

    return _getTextStyle(
        context, fontSizeFactor, color, fontWeightDelta, fontSize);
  }

  TextStyle appBarTextStyle(BuildContext context,
      {double fontSizeFactor = 1, int fontWeightDelta = 0, Color? color}) {
    double fontSize = 20;
    return _getTextStyle(
        context, fontSizeFactor, color, fontWeightDelta, fontSize);
  }

  TextStyle titleMediumTextStile(BuildContext context,
      {fontSizeFactor = 1.1, int fontWeightDelta = 0, Color? color}) {
    double fontSize = 16;
    return _getTextStyle(
        context, fontSizeFactor, color, fontWeightDelta, fontSize);
  }

  TextStyle titleTextStile(BuildContext context,
      {fontSizeFactor = 1.1, int fontWeightDelta = 1, Color? color}) {
    double fontSize = 18;
    return _getTextStyle(
        context, fontSizeFactor, color, fontWeightDelta, fontSize);
  }
  TextStyle titleTextStileAppBar(BuildContext context,
      {fontSizeFactor = 1.0, int fontWeightDelta = 1, Color? color}) {
    double fontSize = 25;
    return _getTextStyle(
        context, fontSizeFactor, color, fontWeightDelta, fontSize);
  }

  TextStyle smallTextStyle(BuildContext context,
      {fontSizeFactor = 1.0, int fontWeightDelta = 0, Color? color}) {
    double fontSize = 12;
    return _getTextStyle(
        context, fontSizeFactor, color, fontWeightDelta, fontSize);
  }

  TextStyle numbersTextStyle(
      {double fontSizeFactor = 0.9,
      fontWeight = FontWeight.w500,
      Color? color}) {
    try {
      final fontSelected = Get.find<AppSettingsController>().state?.fontFamily;
      return TextStyle(
        fontFamily: fontSelected,
        fontSize: 20,
        color: color,
        fontWeight: fontWeight,
      ).apply(fontSizeFactor: fontSizeFactor);
    } catch (e) {
      return TextStyle(
          fontFamily: 'Arial',
          fontSize: 20 * fontSizeFactor,
          fontWeight: fontWeight,
          color: color ?? greyColor);
    }
  }

  EdgeInsets get snackBarPadding =>
      const EdgeInsets.symmetric(horizontal: 16, vertical: 20);
}
