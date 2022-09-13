import 'package:customer_app/endpoints_dir.dart';
import 'package:customer_app/models/documentypes_model.dart';
import 'package:customer_app/providers/data_provider.dart';
import 'package:customer_app/providers/form_data_provider.dart';
import 'package:customer_app/utils/formating/data_formating.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class RegisterService {
  Future<List<DropdownMenuItem<String>>> customerGroups() async {
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
    return list;
  }

  Future<List<DocumentTypesModel>> documentTypes() async {
    // to avoid loading data from server when is already loaded

    final docs = await FormDataProvider.loadDocumenTypes();

    return docs;
  }

  Future<bool> validateDocument(String? vatNo, int? codeDOc) async {
    bool isValidDocument = false;
    final result = await DataProvider.postPetition(
        verifyDocumentEndP, {"vat_no": vatNo, "document_code": codeDOc});
    if (result['success'] ?? false) {
      isValidDocument = true;
    } else {
      isValidDocument = false;
    }
    return isValidDocument;
  }

  Future<Map<String, bool>> validateUserData(
      String? uname, String? email, String? phone) async {
    final Map<String, bool> validFields = {
      'username': false,
      'email': false,
      'phone': false
    };

    final result = await DataProvider.postPetition(verifyUserDataEndP,
        {"email": email, "phone": phone, "username": uname});
    if (!result['success']) {
      if ((result["message"])?.containsKey("username") ?? false) {
        validFields['username'] = false;
      } else {
        validFields['username'] = true;
      }
      if ((result["message"])?.containsKey("phone") ?? false) {
        validFields['phone'] = false;
      } else {
        validFields['phone'] = true;
      }
      if ((result["message"])?.containsKey("email") ?? false) {
        validFields['email'] = false;
      } else {
        validFields['email'] = true;
      }
    } else {
      validFields['username'] = true;
      validFields['email'] = true;
      validFields['phone'] = true;
    }
    return validFields;
  }

  Future<bool> registUser(Map<String, dynamic> body) async {
    final result = await DataProvider.postPetition(createUserEndP, body,
        withAuthToken: false);
    if (result["success"] ?? false) {
      return true;
    }
    return false;
  }
}
