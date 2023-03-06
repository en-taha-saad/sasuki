import 'dart:convert';

import 'package:sasuki/app/resources/language_manager/language_type.dart';
import 'package:sasuki/app/resources/language_manager/language_type_extension.dart';
import 'package:sasuki/data/responses/servers_responses/servers_responses.dart';
import 'package:sasuki/domain/usecase/login_usecase/login_usecase_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefsKeyLang = "prefsKeyLang";
const String prefsKeyIsServerChosed = "prefsKeyIsServerChosed";
const String prefsKeyChosedServer = "prefsKeyChosedServer";
const String prefsKeyEnteredData = "prefsKeyEnteredData";
const String prefsKeyListWithAddedServer = "prefsKeyListWithAddedServer";
const String prefsKeyIsUserLoggedIn = "prefsKeyIsUserLoggedIn";
const String prefsKeyLoginObject = "prefsKeyLoginObject";
const String prefsKeyToken = "prefsKeyToken";
const String prefsKeysetUnsetRememberMe = "prefsKeysetUnsetRememberMe";

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefsKeyLang);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }

  // list of serverData set and get functions (isp name and server address)
  Future<void> setAddToServers(
      Map<String, ServersListResponse> serverJson) async {
    _sharedPreferences.setString(
      prefsKeyListWithAddedServer,
      jsonEncode(serverJson),
    );
  }

  Future<String?> getListOfServers() async {
    return _sharedPreferences.getString(prefsKeyListWithAddedServer);
  }

  removeServers() {
    _sharedPreferences.remove(prefsKeyListWithAddedServer);
  }

  removeSelectedServer() {
    _sharedPreferences.remove(prefsKeyChosedServer);
  }

  removeIsUserLoggedInStatus() {
    _sharedPreferences.remove(prefsKeyIsUserLoggedIn);
  }

  removeToken() {
    _sharedPreferences.remove(prefsKeyToken);
  }

  // SelectedServer set and get functions (isp name and server address)
  Future<void> setSelectedServer(ServerResponse server) async {
    _sharedPreferences.setString(prefsKeyChosedServer, jsonEncode(server));
  }

  Future<String?> getSelectedServer() async {
    return _sharedPreferences.getString(prefsKeyChosedServer);
  }

  Future<void> setIsUserLoggedIn() async {
    _sharedPreferences.setBool(prefsKeyIsUserLoggedIn, true);
  }

  Future<bool> getIsUserLoggedIn() async {
    return _sharedPreferences.getBool(prefsKeyIsUserLoggedIn) ?? false;
  }

  // TODO: get it from login usecase
  Future<void> setLoginObject(LoginUseCaseInput loginUseCaseInput) async {
    _sharedPreferences.setString(
      prefsKeyLoginObject,
      jsonEncode(loginUseCaseInput.toJson()),
    );
  }

  Future<String?> getLoginObject() async {
    return _sharedPreferences.getString(prefsKeyLoginObject);
  }

  Future<void> setToken(String token) async {
    _sharedPreferences.setString(prefsKeyToken, token);
  }

  Future<String?> getToken() async {
    return _sharedPreferences.getString(prefsKeyToken);
  }

  Future<void> setUnsetRememberMe(bool checkRememberMe) async {
    _sharedPreferences.setBool(prefsKeysetUnsetRememberMe, checkRememberMe);
  }

  Future<bool?> getRememberMe() async {
    return _sharedPreferences.getBool(prefsKeysetUnsetRememberMe);
  }
}
