// products endpoints
const String productSearchEndP = 'api/products/search';
const String productDataEndP = 'api/products/productDetails';
// products related data endpoints
const String categoriesEndP = 'api/products/getCategories';
const String taxRatesEndP = 'api/products/getTaxRates';
const String unitsEndP = 'api/products/units';
const String prefCatEndP = 'api/products/preferencesCategories';
const String prefEndP = 'api/products/preferences';
const String unitsPricesEndP = 'api/products/productUnitPrices';
const String prodPrefEndP = 'api/products/productPreferences';

// orders
const String orderCreateEndP = 'api/orders/create';
const String orderCancelEndP = 'api/orders/cancel';
const String orderListEndP = 'api/orders/customerOrders';
const String orderDetailsEndP = 'api/orders/details';
const String ordersCountEndP = 'api/orders/customerOrdersCount';

//companies data

const String customerGroupsEndP = "api/companies/customerCompanyGroups";

const String documentTypesEndP = "api/companies/documentypes";

const String verifyDocumentEndP = "api/companies/verifyVatNo";

const String companyAddressesEndP = "api/companies/companyAddresses";

const String defaultCompanyAddressEndP = "api/companies/defaultAddressData";

const String getAddressDataEndP = "api/companies/addressData";

const String updateCompanyDataEndP = 'api/users/updateUserData';

// addresses

const String createAddressEndP = "api/addresses/create";

//locations

const String getCountriestEndP = "api/locations/countries";
const String getCountryStatesEndP = "api/locations/countryStates";
const String getStateCitiesEndP = "api/locations/stateCities";
const String getCityZonesEndP = "api/locations/cityZones";
const String getZoneSZonesEndP = "api/locations/zoneSubzones";

const String verifyUserDataEndP = "api/users/verifyUserData";

const String createUserEndP = "api/auth/register";

// delivery times

const String avDeliveryTimesEndp = "api/deliveryTimes/avaiable";

/// Application settings
const String appSettingsEndP = "api/applicationInit/initData";

/// Wishlists

const String addWishList = "api/wishList/addFavorite";
const String removeWishList = "api/wishList/removeFavorite";
