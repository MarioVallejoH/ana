import 'dart:async';

import 'package:customer_app/providers/data_provider.dart';
import 'package:customer_app/providers/form_data_provider.dart';
import 'package:customer_app/endpoints_dir.dart';
import 'package:customer_app/models/city_model.dart';
import 'package:customer_app/models/companies_model.dart';
import 'package:customer_app/models/country_model.dart';
import 'package:customer_app/models/documentypes_model.dart';
import 'package:customer_app/models/state_model.dart';
import 'package:customer_app/models/subzone_model.dart';
import 'package:customer_app/auth/models/user_model.dart';
import 'package:customer_app/models/zone_model.dart';

import 'package:customer_app/auth/screens/login.dart';
import 'package:customer_app/theme/color.dart';
import 'package:customer_app/utils/formating/data_formating.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:nb_utils/nb_utils.dart';

import '../../widgets/dialogs_alerts/cool_snackbar_dialog.dart';

class UserRegisterFormProvider extends ChangeNotifier {
  CompanyModel companyData = CompanyModel();

  UserModel? _user;

  // to enable or disable send loginFormData to backend while waiting for response

  bool _isLoading = false;

  bool isValidDocuemt = false;
  bool isValidPhone = false;
  bool isValidUName = false;
  bool isValidEmail = false;

  PageController? pageController;

  GlobalKey<FormState> formKeyP1 = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyP2 = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyP3 = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyP4 = GlobalKey<FormState>();

  List<DropdownMenuItem<String>>? _customerG;
  List<DocumentTypesModel>? _docTypes;
  List<CountryModel>? _countries;
  List<StateModel>? statesI;
  List<CityModel>? citiesI;
  List<ZoneModel>? zonesI;
  List<SubZoneModel>? sZonesI;

  //Streams
  final StreamController<List<StateModel>> _statesController =
      StreamController<List<StateModel>>.broadcast();

  final StreamController<List<CityModel>> _citiesController =
      StreamController<List<CityModel>>.broadcast();

  final StreamController<List<ZoneModel>> _zonesController =
      StreamController<List<ZoneModel>>.broadcast();

  final StreamController<List<SubZoneModel>> _sZonesController =
      StreamController<List<SubZoneModel>>.broadcast();

  // getters

  get loading => _isLoading;

  /// get states stream
  Stream<List<StateModel>> get statesStream => _statesController.stream;

  /// get CITIES stream
  Stream<List<CityModel>> get citiesStream => _citiesController.stream;

  Stream<List<ZoneModel>> get zonesStream => _zonesController.stream;

  Stream<List<SubZoneModel>> get sZonesStream => _sZonesController.stream;

  // setters
  set isLoading(bool value) {
    _isLoading = value;
  }

  Function(List<StateModel>) get setStates => _statesController.sink.add;

  Function(List<CityModel>) get setCities => _citiesController.sink.add;

  Function(List<ZoneModel>) get setZones => _zonesController.sink.add;

  Function(List<SubZoneModel>) get setSZones => _sZonesController.sink.add;

  Future<void> reloadStateCity() async {
    if (companyData.selCountry != null) {
      companyData.selCity = null;
      companyData.selState = null;
      final states = await FormDataProvider.loadCountryStates(
          companyData.selCountry!.codigo);
      statesI = states;
      setStates(states);
      setCities([]);

      // delete selected state and city}

    }
  }

  Future<void> reloadCity() async {
    if (companyData.selState != null) {
      companyData.selCity = null;
      final cities = await FormDataProvider.loadStateCities(
          companyData.selState!.coddepartamento);
      citiesI = cities;
      setCities(cities);

      // delete selected state and city}

    }
  }

  Future<void> reloadZones() async {
    if (companyData.selCity != null) {
      companyData.zone = null;
      final zones =
          await FormDataProvider.loadCityZones(companyData.selCity!.codigo);
      zonesI = zones;
      setZones(zones);

      // delete selected state and city}

    }
  }

  Future<void> reloadSZones() async {
    if (companyData.zone != null) {
      companyData.sZone = null;
      final sZones =
          await FormDataProvider.loadZoneSZones(companyData.zone!.zoneCode);
      sZonesI = sZones;
      setSZones(sZones);

      // delete selected state and city}

    }
  }

  UserModel userData() {
    if (_user != null) {
      return _user!;
    } else {
      if (companyData.typePerson == "1") {
        _user = UserModel(
            email: companyData.email ?? "",
            phone: companyData.phone ?? "",
            username: "",
            firstName: companyData.firstName ?? "",
            firstLastname: companyData.firstLastname ?? "",
            password: "");
      }
      _user = UserModel(
          email: companyData.email ?? "",
          phone: companyData.phone ?? "",
          username: "",
          firstName: "",
          firstLastname: "",
          password: "");
      return _user!;
    }
  }

  void setUserData({
    String? username,
    String? email,
    String? phone,
    String? password,
    String? firstName,
    String? firstLastName,
  }) {
    // userData();
    if (username != null) {
      _user?.username = username;
    }
    if (email != null) {
      _user?.email = email;
    }
    if (phone != null) {
      _user?.phone = phone;
    }
    if (firstName != null) {
      _user?.firstName = firstName;
    }
    if (firstLastName != null) {
      _user?.firstLastname = firstLastName;
    }
    if (password != null) {
      _user?.password = password;
    }
  }

  bool isValidFormP1() {
    return formKeyP1.currentState?.validate() ?? false;
  }

  Future<bool> isValidFormP2() async {
    if ((companyData.vatNo?.isNotEmpty ?? false) && !isValidDocuemt) {
      final result = await DataProvider.postPetition(verifyDocumentEndP, {
        "vat_no": companyData.vatNo,
        "document_code": companyData.docType?.codigoDoc
      });
      if (result['success'] ?? false) {
        isValidDocuemt = true;
      } else {
        isValidDocuemt = false;
      }
    }
    return formKeyP2.currentState?.validate() ?? false;
  }

  bool isValidFormP3() {
    return formKeyP3.currentState?.validate() ?? false;
  }

  Future<bool> isValidFormP4() async {
    final result = await DataProvider.postPetition(verifyUserDataEndP, {
      "email": _user?.email,
      "phone": _user?.phone,
      "username": _user?.username
    });
    if (!result['success']) {
      if ((result["message"])?.containsKey("username") ?? false) {
        isValidUName = false;
      } else {
        isValidUName = true;
      }
      if ((result["message"])?.containsKey("phone") ?? false) {
        isValidPhone = false;
      } else {
        isValidPhone = true;
      }
      if ((result["message"])?.containsKey("email") ?? false) {
        isValidEmail = false;
      } else {
        isValidEmail = true;
      }
    } else {
      isValidPhone = true;
      isValidEmail = true;
      isValidUName = true;
    }

    return formKeyP4.currentState?.validate() ?? false;
  }

  Future<void> currentPageValidation(BuildContext context) async {
    int page = pageController?.page?.toInt() ?? 0;
    switch (page) {
      case 0:
        if (isValidFormP1()) {
          _goToNextPage();
        }
        break;
      case 1:
        if (await isValidFormP2()) {
          _goToNextPage();
        }
        break;
      case 2:
        if (isValidFormP3()) {
          _goToNextPage();
        }
        break;
      case 3:
        if (await isValidFormP4()) {
          await createCustomer(context);
        }
        break;
    }
  }

  void _goToNextPage() {
    int page = (pageController?.page ?? 0).toInt() + 1;
    pageController?.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  Map<String, dynamic> _toJson({bool createAddress = true}) {
    final Map<String, dynamic> json = {
      "user_data": _user?.toJson(),
      "company_data": companyData.customerToJson(),
      "create_address": createAddress
    };

    return json;
  }

  Future<bool> createCustomer(BuildContext context) async {
    // add extra data to user
    _user?.gender = companyData.gender;
    _user?.company = companyData.company;

    final body = _toJson();

    final result = await DataProvider.postPetition(createUserEndP, body,
        withAuthToken: false);

    if (result["success"] ?? false) {
      String title = 'Usuario creado con exito.';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        content: CustomSnackBarContent(
          title: title,
          bgColor: okColorWappsi,
          onlyTitle: true,
          assetImageDir: 'assets/images/icons/tick.png',
          // onlyTitle: true,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ));
      const Login().launch(context,
          duration: const Duration(milliseconds: 300),
          pageRouteAnimation: PageRouteAnimation.SlideBottomTop,
          isNewTask: true);
    } else {
      String title = 'Ha ocurrido un error al crear el usuario.';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        content: CustomSnackBarContent(
          title: title,
          onlyTitle: true,
          bgColor: errorColor2,
          // onlyTitle: true,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ));
    }

    return false;
  }

  Future<List<DropdownMenuItem<String>>> customerGroups() async {
    // to avoid loading data from server when is already loaded
    if (_customerG != null && (_customerG?.isNotEmpty ?? false)) {
      return _customerG!;
    }
    Map<String, dynamic> data = await FormDataProvider.loadCustomerGroups();
    List<DropdownMenuItem<String>> list = [];
    if (data['success'] ?? false) {
      if (data['data'] is List) {
        try {
          for (Map element in data['data']) {
            if (list.where((e) => element['íd'] == e.value).isEmpty) {}
            list.add(DropdownMenuItem<String>(
              child: Text(capitalizeText(element['name'])),
              value: element['id']?.toString(),
            ));
          }
        } catch (e) {
          log(e);
        }
      }
    }
    _customerG = list;
    return list;
  }

  Future<List<DocumentTypesModel>> documentTypes() async {
    // to avoid loading data from server when is already loaded
    if (_docTypes != null && (_docTypes?.isNotEmpty ?? false)) {
      return _docTypes!.toSet().toList();
    }
    final docs = await FormDataProvider.loadDocumenTypes();
    _docTypes = docs;

    return docs;
  }

  Future<List<CountryModel>> countries() async {
    // to avoid loading data from server when is already loaded
    if (_countries != null && (_countries?.isNotEmpty ?? false)) {
      return _countries!;
    }
    final countries = await FormDataProvider.loadCountries();
    _countries = countries;

    return countries;
  }

  @override
  void dispose() {
    super.dispose();
    _statesController.close();
    _zonesController.close();
    _sZonesController.close();
    _citiesController.close();
  }
}

class PersonRegistrationFormProvider extends ChangeNotifier {
  String email = '';
  String passsword = '';

  String regimenType = "";

  String personType = "";

  // to enable or disable send loginFormData to backend while waiting for response

  bool _isLoading = false;

  get loading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  // Map<String, dynamic> _toJson() {
  //   final body = AuthService.apiClientData;
  //   body.addAll({
  //     'username': email.replaceAll(' ', ''),
  //     'password': encodePass(passsword),
  //   });
  //   return body;
  // }

  Future<bool> createCustomer(BuildContext context) async {
    // final resp = {'': 2};

    return false;
  }
}
