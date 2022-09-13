import 'package:customer_app/routes/controllers/app_settings_controller.dart';
import 'package:customer_app/utils/color/from_hex_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
const secondary = Color(0xFFe96561);

Color get colorOnPColor => barMenuTextColor;

const deleteColor = Colors.red;

const errorColor2 = Colors.red;

const okColorWappsi = Color.fromRGBO(0, 176, 82, 1);

const bottomBarIconsColor = Color.fromRGBO(247, 247, 247, 1);

const cartItemColor = Color.fromRGBO(247, 247, 247, 1);

final skeletonShimerColor = Colors.grey[500];

const mainColor = Color(0xFF000000);
const darker = Color(0xFF3E4249);
final appBgColor = backgroundPageColor;
const appBarColor = Color(0xFFF7F7F7);
const bottomBarColor = Colors.white;
const inActiveColor = Colors.grey;
const shadowColor = Colors.black87;
const textBoxColor = Colors.white;
const textColor = Color(0xFF333333);
const labelColor = Color(0xFF8A8989);

const actionColor = Color(0xFFe54140);
const buttonColor = Color(0xFFcdacf9);
const cardColor = Colors.white;

final ticketBgColor = HexColor.fromHex('#F5F5F5');

const yellow = Color(0xFFffcb66);
const green = Color(0xFFa2e1a6);
const pink = Color(0xFFf5bde8);
const purple = Color(0xFFcdacf9);
const red = Color(0xFFf77080);
const orange = Color(0xFFf5ba92);
const sky = Color(0xFFABDEE6);
const blue = Color(0xFF509BE4);
const cyan = Color(0xFF4ac2dc);
const darkerGreen = Color(0xFFb0d96d);

/// Color to subtitles
Color greyColor = const Color.fromARGB(255, 69, 69, 69);

Color greyLight = Colors.grey[100]!;

Color greyDarkerLight = Colors.grey[200]!;

Color greyMediumLight = Colors.grey[300]!;

Color greyDLight = Colors.grey[400]!;

/// Color darker to subtitles
Color greyDarkerColor = Colors.grey[800]!;

const listColors = [
  green,
  purple,
  yellow,
  orange,
  sky,
  secondary,
  red,
  blue,
  pink,
  yellow,
];
