import 'package:customer_app/models/companies_model.dart';
import 'package:customer_app/auth/models/user_data_model.dart';
import 'package:customer_app/providers/data_provider.dart';
import 'package:customer_app/params.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthService {
  String refreshEndp = "/api/auth/refreshToken";
  Future<void> saveRefreshToken(String refreshToken) async {
    await setValue("refresh_token", refreshToken);
  }

  Future<void> saveAccessToken(String accessToken) async {
    await setValue("access_token", accessToken);
  }

  Future<void> deleteUserSelectedAddress() async {
    await setValue("user_sel_address", '');
    log('Removed selected address');
  }

  String get refreshToken => getStringAsync("refresh_token");

  String get accessToken => getStringAsync("access_token");

  Map<String, dynamic> get apiClientData =>
      {"client_id": clientId, "client_secret": clientSecret, "scope": ""};

  Map<String, String> getHeaders({bool withAuthToken = false}) {
    final headers = {
      'content-Type': 'application/json',
      "Accept": "application/json"
    };

    if (withAuthToken) {
      headers['Authorization'] = 'Bearer ' + accessToken;
    }

    return headers;
  }

  Map<String, dynamic> getRefreshTokenData() {
    final data = apiClientData;

    data['refresh_token'] = refreshToken;

    return data;
  }

  Future<bool> refreshTokens() async {
    final response = await DataProvider.postPetition(
        refreshEndp, getRefreshTokenData(),
        withAuthToken: false);
    bool success = false;

    if (response.containsKey('access_token') &&
        response.containsKey('refresh_token')) {
      await Future.wait([
        saveAccessToken(response['access_token']),
        saveRefreshToken(response['refresh_token'])
      ]);
      success = true;
    }

    return success;
  }

  bool alreadyLogged() {
    bool alreadyLogged = false;
    log(accessToken);
    if (accessToken.isNotEmpty) {
      alreadyLogged = true;
    }
    return alreadyLogged;
  }

  Future<UserDataModel?> autologin() async {
    try {
      final userData =
          await DataProvider.getPetition('api/auth/getUserData', auth: true);
      UserDataModel userModel = UserDataModel.fromJson(userData['user_data']);
      final userCompany = CompanyModel.fromJson(userData['user_company_data']);
      userModel.companyData = userCompany;
      // DataBloc().setUserData(userModel);
      return userModel;
    } catch (e) {
      log(e);
    }
    return null;
  }

  Future<bool> logout() async {
    await saveAccessToken('');
    await saveRefreshToken('');
    await deleteUserSelectedAddress();
    
    final result =
        await DataProvider.getPetition('api/auth/logout', auth: true);
    if (result['success'] ?? false) {
      return true;
    }
    return false;
  }
}
