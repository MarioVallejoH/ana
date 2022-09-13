import 'package:customer_app/auth/services/auth_service.dart';
import 'package:customer_app/routes/routes.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/encoding.dart';
import '../../models/companies_model.dart';
import '../models/user_data_model.dart';
import '../../providers/data_provider.dart';

class AuthController extends GetxController with StateMixin<UserDataModel?> {
  AuthController({required this.service}) {
    change(null, status: RxStatus.loading());
  }

  @override
  void onInit() async {
    if (isLogged()) {
      await autoLogin();
    } else {
      change(null, status: RxStatus.success());
    }

    super.onInit();
  }

  final AuthService service;

  final _loginEndp = "/api/auth/login";

  final Rx<TextEditingController> _uname = TextEditingController().obs;
  final Rx<TextEditingController> _passsword = TextEditingController().obs;

  // to enable or disable send loginFormData to backend while waiting for response

  late FocusNode passwordFocusNode = FocusNode();
  late FocusNode userFocusNode = FocusNode();

  final Rx<bool> _isLoading = false.obs;

  get uname => _uname.value.text;
  TextEditingController get unameController => _uname.value;

  get passsword => _passsword.value.text;
  TextEditingController get passwordController => _passsword.value;

  get loading => _isLoading.value;

  set isLoading(bool value) {
    _isLoading.value = value;
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Map<String, dynamic> _toJson() {
    final body = service.apiClientData;
    body.addAll({
      'username': uname.replaceAll(' ', ''),
      'password': encodePass(passsword),
    });
    return body;
  }

  Future<bool> login(BuildContext context) async {
    // final resp = {'': 2};

    final resp = await DataProvider.postPetition(_loginEndp, _toJson(),
        withAuthToken: false);

    if (resp['success'] ?? false) {
      final user = UserDataModel.fromJson(resp['user_data']);
      try {
        final userCompany = CompanyModel.fromJson(resp['user_company_data']);
        user.companyData = userCompany;
        change(user, status: RxStatus.success());
      } catch (e) {
        log(e);
        change(null, status: RxStatus.empty());
      }

      // final authController = Get.find<AuthController>();
      service
          .saveAccessToken(resp['tokens_data']['access_token']);
      service
          .saveRefreshToken(resp['tokens_data']['refresh_token']);

      Get.toNamed(Routes.home);
      return true;
    }
    change(null, status: RxStatus.success());
    return false;
  }

  bool isLogged() {
    return service.alreadyLogged();
  }

  Future<bool> autoLogin() async {
    change(null, status: RxStatus.loading());
    final uData = await service.autologin();

    if (uData != null) {
      change(uData, status: RxStatus.success());

      Get.toNamed(Routes.home);
      return true;
    } else {
      change(uData, status: RxStatus.success());

      return false;
    }
  }

  Future<bool> updateUserData() async {
    final uData = await service.autologin();

    if (uData != null) {
      change(uData, status: RxStatus.success());
      return true;
    } else {
      change(uData, status: RxStatus.success());

      return false;
    }
  }

  Future<bool> logout() async {
    final res = await service.logout();
    if (res) {
      change(null, status: RxStatus.success());
      return true;
    } else {
      return false;
    }
  }

  Future<bool> refreshToken() async {
    final res = await service.refreshTokens();
    if (res) {
      change(null, status: RxStatus.success());
      return true;
    } else {
      return false;
    }
  }

  @override
  dispose() {
    userFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}
