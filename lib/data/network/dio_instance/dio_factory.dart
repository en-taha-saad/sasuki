import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sasuki/app/app_inits_funs/app_prefs.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/data/network/dio_instance/dio_instance_constants.dart';

class DioFactory {
  final AppPreferences _appPreferences;
  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    String? token = await _appPreferences.getToken();
    Dio dio = Dio();
    String language = await _appPreferences.getAppLanguage();
    String serverAddress =
        await _appPreferences.getSelectedServer() ?? Constants.serverAddress;
    // ignore: no_leading_underscores_for_local_identifiers
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: "Bearer $token",
      defaultLanguage: language,
    };
    dio.options = BaseOptions(
      baseUrl: "https://$serverAddress/${Constants.suffixUrl}",
      connectTimeout: Constants.apiTimeOut,
      receiveTimeout: Constants.apiTimeOut,
      headers: headers,
    );

    if (!kReleaseMode) {
      // its for debug m ode only
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }
    return dio;
  }
}
