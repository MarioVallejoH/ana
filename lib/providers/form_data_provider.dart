import 'package:customer_app/endpoints_dir.dart';
import 'package:customer_app/models/city_model.dart';
import 'package:customer_app/models/country_model.dart';
import 'package:customer_app/models/documentypes_model.dart';
import 'package:customer_app/models/state_model.dart';
import 'package:customer_app/models/subzone_model.dart';
import 'package:customer_app/models/zone_model.dart';
import 'package:nb_utils/nb_utils.dart';


import 'data_provider.dart';

class FormDataProvider {
  static Future<List<DocumentTypesModel>> loadDocumenTypes() async {
    final data = await DataProvider.getPetition(documentTypesEndP);
    List<DocumentTypesModel> list = [];
    if (data['success'] ?? false) {
      try {
        list = DocumentTypesModel.fromJsonList(data['data']);
      } catch (e) {
        log(e);
      }
    }
    return list;
  }

  static Future<List<CountryModel>> loadCountries() async {
    final data = await DataProvider.getPetition(getCountriestEndP);
    List<CountryModel> list = [];
    if (data['success'] ?? false) {
      if (data['data'] is List) {
        try {
          for (Map element in data['data']) {
            final country = CountryModel.fromJson(element);
            list.add(
              country,
            );
          }
        } catch (e) {
          log(e);
        }
      }
    }
    return list;
  }

  static Future<List<StateModel>> loadCountryStates(String countryCode) async {
    final data = await DataProvider.postPetition(
        getCountryStatesEndP, {"country_code": countryCode});
    List<StateModel> list = [];
    if (data['success'] ?? false) {
      if (data['data'] is List) {
        try {
          for (Map element in data['data']) {
            final state = StateModel.fromJson(element);
            list.add(state);
          }
        } catch (e) {
          log(e);
        }
      }
    }
    return list;
  }

  static Future<List<CityModel>> loadStateCities(String stateCode) async {
    final data = await DataProvider.postPetition(
        getStateCitiesEndP, {"state_code": stateCode});
    List<CityModel> list = [];
    if (data['success'] ?? false) {
      if (data['data'] is List) {
        try {
          for (Map element in data['data']) {
            final city = CityModel.fromJson(element);
            list.add(city);
          }
        } catch (e) {
          log(e);
        }
      }
    }
    return list;
  }

  static Future<List<ZoneModel>> loadCityZones(String cityCode) async {
    final data = await DataProvider.postPetition(
        getCityZonesEndP, {"city_code": cityCode});
    List<ZoneModel> list = [];
    if (data['success'] ?? false) {
      if (data['data'] is List) {
        try {
          for (Map element in data['data']) {
            final zone = ZoneModel.fromJson(element);
            list.add(zone);
          }
        } catch (e) {
          log(e);
        }
      }
    }
    return list;
  }

  static Future<List<SubZoneModel>> loadZoneSZones(String zoneCode) async {
    final data = await DataProvider.postPetition(
        getZoneSZonesEndP, {"zone_code": zoneCode});
    List<SubZoneModel> list = [];
    if (data['success'] ?? false) {
      if (data['data'] is List) {
        try {
          for (Map element in data['data']) {
            final sZone = SubZoneModel.fromJson(element);
            list.add(sZone);
          }
        } catch (e) {
          log(e);
        }
      }
    }
    return list;
  }

  static Future<Map<String, dynamic>> loadCustomerGroups() async {
    final data = await DataProvider.getPetition(customerGroupsEndP);
    return data;
  }
}
