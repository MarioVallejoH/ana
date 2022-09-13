// ignore_for_file: implementation_imports

import 'dart:convert';

import 'package:customer_app/auth/controller/auth_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:nb_utils/nb_utils.dart';

import 'dart:async';
import 'dart:io';

import '../services/url_resources_service.dart';

class DataProvider {
  // POST petitons
  static Future<Map<String, dynamic>> postPetition(
      String endpoint, Map<String, dynamic> data,
      {int awaitTime = 30, bool withAuthToken = false}) async {
    // ignore: prefer_typing_uninitialized_variables
    var resp;
    var dio = Dio();
    dio.options.baseUrl = UrlResourcesService.host;

    dio.options.headers = Get.find<AuthController>()
        .service
        .getHeaders(withAuthToken: withAuthToken);
    // to seconds to milliseconds, seconds * 1000
    dio.options.receiveTimeout = awaitTime * 1000;
    dio.options.method = 'POST';
    if (withAuthToken) {
      // dio.interceptors.add(AuthInterceptor(
      //     requestRetrier: DioConnectivityRequestRetrier(
      //   dio: dio,
      //   connectivity: Connectivity(),
      // )));
    }
    // ignore: unused_local_variable
    final data2 = jsonEncode(data);

    try {
      resp = await dio
          .post(endpoint, data: data)
          .timeout(Duration(seconds: awaitTime), onTimeout: () {
        throw TimeoutException('Now answer, try again.');
      });
      dynamic decodedRespBody;

      if (resp.data is Map) {
        decodedRespBody = resp.data;
      } else {
        // printConsole(resp.body.toString());
        return {
          'success': false,
          'message': "Respuesta inesperada",
          'data': []
        };
      }

      // printConsole(resp['status']);
      return decodedRespBody;
    } on SocketException {
      return {
        'success': false,
        'message': 'Verifica tu conexión a internet',
      };
      // controlador = 'sinConexion';
    } on TimeoutException {
      return {
        'success': false,
        'message': 'Sin respuesta, intenta de nuevo',
      };
    } catch (e) {
      // await logError(e, from: 'Api provider, http.post');
      log(e);
      return {
        'success': false,

        'message': 'Error de conexión con el servidor',
        // 'message': 'Error de conexión con el servidor: ${e.toString()}',
      };
    }
  }

  // GET
  static Future<Map<String, dynamic>> getPetition(String endpoint,
      {bool auth = false}) async {
    // ignore: prefer_typing_uninitialized_variables
    var resp;

    var dio = Dio();
    // headers['Access-Control-Allow-Origin'] = '*';

    dio.options.baseUrl = UrlResourcesService.host;
    dio.options.headers = Get.find<AuthController>()
        .service.getHeaders(withAuthToken: auth);
    dio.options.method = 'GET';
    // String url =
    //     (dataBloc.userData == null ? HOST : dataBloc.userData?.hostUrl ?? '') +
    //         '/wappsi_apis/$endpoint';
    try {
      resp = await dio.get(endpoint);

      dynamic decodedRespBody;
      if (resp.data is Map) {
        decodedRespBody = resp.data;
      } else {
        return {
          'success': true,
          'body': {'message': "Respuesta inesperada"}
        };
      }

      String message = '';
      try {
        final messages = decodedRespBody['message'] as Map;
        message = messages.values.toList().join(' ');
      } catch (e) {
        // await logError(e, from: 'Api provider, http.post');
        message = decodedRespBody['message'].toString();
      }
      decodedRespBody['message'] = message;

      // if (decodedRespBody['reload'] ?? false) {
      //   // to handle JWT problems
      //   return decodedRespBody;
      // } else {
      return decodedRespBody;
      // }
    } on SocketException {
      return {
        'success': true,
        'message': 'Verifica tu conexión a internet',
      };
      // controlador = 'sinConexion';
    } on TimeoutException {
      return {
        'success': true,
        'message': 'Sin respuesta, intenta de nuevo',
      };
    } catch (e) {
      // await logError(e, from: 'Api provider, http.get');
      return {
        'success': true,
        'message': 'Petición fallida',
      };
    }
  }
}

class AuthInterceptor extends InterceptorsWrapper {
  final DioConnectivityRequestRetrier requestRetrier;

  AuthInterceptor({
    required this.requestRetrier,
  });
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // print(options.baseUrl + options.path);

    var accessToken = Get.find<AuthController>()
        .service.accessToken;
    if (accessToken.isEmpty) {
      log('trying to send request without token exist!');
      return super.onRequest(options, handler);
    }
    // options.headers["Authorization"] = "Bearer " + accessToken.toString();
    return super.onRequest(options, handler);
  }

  // @override
  // onResponse(Response response, ResponseInterceptorHandler handler) {
  //   return super.onResponse(response, handler);
  // }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) async {
    // var url = err.request.uri;
    log("************************************************");
    log(err);

    super.onError(err, handler);
    if (err.response?.statusCode == 401) {
      if (Get.find<AuthController>()
        .service.refreshToken.isNotEmpty) {
        final refresh = await Get.find<AuthController>()
        .service.refreshTokens();
        if (refresh) {
          final response =
              await requestRetrier.scheduleRequestRetry(err.requestOptions);

          handler.resolve(response);
        }
        handler.next(err);
      }
      Get.find<AuthController>()
        .service.logout();
    }
  }
}

class DioConnectivityRequestRetrier {
  final Dio dio;
  final Connectivity connectivity;

  DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    StreamSubscription? streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) async {
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription?.cancel();
          // Complete the completer instead of returning
          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              options: Options(
                  method: requestOptions.method,
                  headers: Get.find<AuthController>()
        .service.getHeaders(withAuthToken: true,),),
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}
