class UrlResourcesService {
  static const String imagesDir1 = 'assets/uploads/';
  static const String companyFolder = 'erp/';

  static const String hostUrlBase = 'http://lapappaya.com/';

  static const String host = hostUrlBase + 'lapappaya_customer_api/';
  static const imagesUpUrlBase = hostUrlBase + companyFolder + imagesDir1;
  static const imagesLogosUpUrlBase =
      hostUrlBase + companyFolder + imagesDir1 + 'logos/';

  static String getProductImgUrl(String pImage) {
    return imagesUpUrlBase + (pImage == '' ? 'no_image.png' : pImage);
  }

  static String getImgUrl(String pImage) {
    return imagesUpUrlBase + (pImage == '' ? 'no_image.png' : pImage);
  }

  static String getCompanyImgUrl(String cImage) {
    return imagesLogosUpUrlBase + (cImage == '' ? 'no_image.png' : cImage);
  }
}
