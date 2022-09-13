

import 'package:customer_app/endpoints_dir.dart';
import 'package:customer_app/home/images/controller/image_controller.dart';
import 'package:customer_app/auth/controller/auth_controller.dart';
import 'package:customer_app/auth/models/user_data_model.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:get/get.dart';

import '../../providers/data_provider.dart';

class UserController extends GetxController {
  @override
  void onInit() {
    _firstName.value.text = userData?.companyData?.firstName ?? '';
    _secondName.value.text = userData?.companyData?.secondName ?? '';
    _firstLastname.value.text = userData?.companyData?.firstLastname ?? '';
    _secondLastname.value.text = userData?.companyData?.secondLastname ?? '';
    super.onInit();
  }

  UserController({required this.userData});
  final UserDataModel? userData;

  final Rx<TextEditingController> _firstName = TextEditingController().obs;
  final Rx<TextEditingController> _secondName = TextEditingController().obs;
  final Rx<TextEditingController> _firstLastname = TextEditingController().obs;
  final Rx<TextEditingController> _secondLastname = TextEditingController().obs;

  final Rx<TextEditingController> _password = TextEditingController().obs;

  final RxBool _editUserData = false.obs;

  // to enable or disable send loginFormData to backend while waiting for response

  late FocusNode passwordFocusNode = FocusNode();
  late FocusNode userFocusNode = FocusNode();

  final Rx<bool> _isLoading = false.obs;

  bool get editUserData => _editUserData.value;

  set editUserData(bool value) {
    _editUserData.value = value;
  }

  String get firstName => _firstName.value.text;
  set firstName(String value) => _firstName.value.text;
  get firstNameController => _firstName.value;

  String get secondName => _secondName.value.text;
  set secondName(String value) => _secondName.value.text;
  get secondNameController => _secondName.value;

  String get firstLastname => _firstLastname.value.text;
  set firstLastname(String value) => _firstLastname.value.text;
  get firstLastnameController => _firstLastname.value;

  String get secondLastname => _secondLastname.value.text;
  set secondLastname(String value) => _secondLastname.value.text;
  get secondLastnameController => _secondLastname.value;

  String get password => _password.value.text;
  set password(String value) => _password.value.text;
  get passwordController => _password.value;

  bool get loading => _isLoading.value;

  set loading(bool value) {
    _isLoading.value = value;
  }

  Map<String, dynamic> _toJson() {
    final Map<String, dynamic> body = {};
    if (editUserData) {
      body['first_name'] = firstName;
      body['second_name'] = secondName;
      body['first_lastname'] = firstLastname;
      body['second_lastname'] = secondLastname;
      // body['password'] = password;
      body['name'] =
          '$firstName $secondName $firstLastname $secondLastname ';
    }
    return body;
  }

  Future<bool> saveUserChanges(BuildContext context) async {
    // final resp = {'': 2};
    final data = _toJson();
    if (data.isNotEmpty) {
      data['id'] = userData?.companyData?.id;
    }
    final imgController = Get.find<ImageController>();
    if (imgController.photo?.path.isNotEmpty??false) {
      data['image'] = await imgController.imageB64();
    }
    final resp = await DataProvider.postPetition(updateCompanyDataEndP, data,
        withAuthToken: false);

    if (resp['success'] ?? false) {
      await Get.find<AuthController>().updateUserData();
      return true;
    }
    return false;
  }

  @override
  dispose() {
    userFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}
