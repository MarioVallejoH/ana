// To parse this JSON data, do
//
//     final AppSettingsModel = AppSettingsModelFromJson(jsonString);

import 'dart:convert';

import 'package:customer_app/models/biller_data_model.dart';
import 'package:customer_app/models/companies_model.dart';
import 'package:customer_app/utils/parsing/numeric_paring.dart';

class AppSettingsModel {
  AppSettingsModel({
    this.shopId,
    this.description,
    this.biller,
    this.aboutLink,
    this.termsLink,
    this.privacyLink,
    this.contactLink,
    this.paymentText,
    this.followText,
    this.facebook,
    this.twitter,
    this.googlePlus,
    this.instagram,
    this.cookieMessage,
    this.cookieLink,
    this.slider,
    this.shipping,
    this.purchaseCode,
    this.envatoUsername,
    this.version,
    this.bankDetails,
    this.productsPage,
    this.hide0,
    this.showProductQuantity,
    this.showProductZeroPrice,
    this.showProductZeroQuantity,
    this.showCategoriesWithoutProducts,
    this.overselling,
    this.useProductVariants,
    this.useProductPreferences,
    this.primaryColor,
    this.barMenuColor,
    this.fontTextColor,
    this.secondaryColor,
    this.fontFamily,
    this.backgroundPageColor,
    this.headerColor,
    this.footerColor,
    this.headerMessageColor,
    this.productView,
    this.shopFavicon,
    this.navbarColor,
    this.navbarTextColor,
    this.barMenuTextColor,
    this.footerTextColor,
    this.promotionTextColor,
    this.favoriteColor,
    this.saleDestination,
    this.billerData,
    this.companyData,
  });

  int? shopId;
  String? description;
  int? biller;
  String? aboutLink;
  String? termsLink;
  String? privacyLink;
  String? contactLink;
  String? paymentText;
  String? followText;
  String? facebook;
  String? twitter;
  String? googlePlus;
  String? instagram;
  String? cookieMessage;
  String? cookieLink;
  String? slider;
  dynamic shipping;
  String? purchaseCode;
  String? envatoUsername;
  String? version;
  String? bankDetails;
  int? productsPage;
  int? hide0;
  int? showProductQuantity;
  int? showProductZeroPrice;
  int? showProductZeroQuantity;
  int? showCategoriesWithoutProducts;
  int? overselling;
  int? useProductVariants;
  int? useProductPreferences;
  String? primaryColor;
  String? barMenuColor;
  String? fontTextColor;
  String? secondaryColor;
  String? fontFamily;
  String? backgroundPageColor;
  String? headerColor;
  String? footerColor;
  String? headerMessageColor;
  int? productView;
  String? shopFavicon;
  String? navbarColor;
  String? navbarTextColor;
  String? barMenuTextColor;
  String? footerTextColor;
  String? promotionTextColor;
  String? favoriteColor;
  int? saleDestination;

  BillerDataModel? billerData;
  CompanyModel? companyData;

  Map<String, dynamic> settings = {};

  factory AppSettingsModel.fromRawJson(String str) =>
      AppSettingsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) =>
      AppSettingsModel(
          shopId: parsingToIntNullable(json["shop_id"]),
          description: json["description"],
          biller: parsingToIntNullable(json["biller"]),
          aboutLink: json["about_link"],
          termsLink: json["terms_link"],
          privacyLink: json["privacy_link"],
          contactLink: json["contact_link"],
          paymentText: json["payment_text"],
          followText: json["follow_text"],
          facebook: json["facebook"],
          twitter: json["twitter"],
          googlePlus: json["google_plus"],
          instagram: json["instagram"],
          cookieMessage: json["cookie_message"],
          cookieLink: json["cookie_link"],
          slider: json["slider"],
          shipping: json["shipping"],
          purchaseCode: json["purchase_code"],
          envatoUsername: json["envato_username"],
          version: json["version"],
          bankDetails: json["bank_details"],
          productsPage: json["products_page"],
          hide0: parsingToIntNullable(json["hide0"]),
          showProductQuantity:
              parsingToIntNullable(json["show_product_quantity"]),
          showProductZeroPrice:
              parsingToIntNullable(json["show_product_zero_price"]),
          showProductZeroQuantity:
              parsingToIntNullable(json["show_product_zero_quantity"]),
          showCategoriesWithoutProducts:
              parsingToIntNullable(json["show_categories_without_products"]),
          overselling: parsingToIntNullable(json["overselling"]),
          useProductVariants:
              parsingToIntNullable(json["use_product_variants"]),
          useProductPreferences:
              parsingToIntNullable(json["use_product_preferences"]),
          primaryColor: json["primary_color"],
          barMenuColor: json["bar_menu_color"],
          fontTextColor: json["font_text_color"],
          secondaryColor: json["secondary_color"],
          fontFamily: json["font_family"],
          backgroundPageColor: json["background_page_color"],
          headerColor: json["header_color"],
          footerColor: json["footer_color"],
          headerMessageColor: json["header_message_color"],
          productView: parsingToIntNullable(json["product_view"]),
          shopFavicon: json["shop_favicon"],
          navbarColor: json["navbar_color"],
          navbarTextColor: json["navbar_text_color"],
          barMenuTextColor: json["bar_menu_text_color"],
          footerTextColor: json["footer_text_color"],
          promotionTextColor: json["promotion_text_color"],
          favoriteColor: json["favorite_color"],
          saleDestination: parsingToIntNullable(json["sale_destination"]),
          billerData: BillerDataModel.fromJson(json["biller_data"]),
          companyData: CompanyModel.fromJson(json["company_data"]));

  Map<String, dynamic> toJson() => {
        "shop_id": shopId,
        "description": description,
        "biller": biller,
        "about_link": aboutLink,
        "terms_link": termsLink,
        "privacy_link": privacyLink,
        "contact_link": contactLink,
        "payment_text": paymentText,
        "follow_text": followText,
        "facebook": facebook,
        "twitter": twitter,
        "google_plus": googlePlus,
        "instagram": instagram,
        "cookie_message": cookieMessage,
        "cookie_link": cookieLink,
        "slider": slider,
        "shipping": shipping,
        "purchase_code": purchaseCode,
        "envato_username": envatoUsername,
        "version": version,
        "bank_details": bankDetails,
        "products_page": productsPage,
        "hide0": hide0,
        "show_product_quantity": showProductQuantity,
        "show_product_zero_price": showProductZeroPrice,
        "show_product_zero_quantity": showProductZeroQuantity,
        "show_categories_without_products": showCategoriesWithoutProducts,
        "overselling": overselling,
        "use_product_variants": useProductVariants,
        "use_product_preferences": useProductPreferences,
        "primary_color": primaryColor,
        "bar_menu_color": barMenuColor,
        "font_text_color": fontTextColor,
        "secondary_color": secondaryColor,
        "font_family": fontFamily,
        "background_page_color": backgroundPageColor,
        "header_color": headerColor,
        "footer_color": footerColor,
        "header_message_color": headerMessageColor,
        "product_view": productView,
        "shop_favicon": shopFavicon,
        "navbar_color": navbarColor,
        "navbar_text_color": navbarTextColor,
        "bar_menu_text_color": barMenuTextColor,
        "footer_text_color": footerTextColor,
        "promotion_text_color": promotionTextColor,
        "favorite_color": favoriteColor,
        "sale_destination": saleDestination,
      };
}
