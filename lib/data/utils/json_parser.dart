import 'dart:convert';

import 'package:flutter/services.dart';

class JsonParser {
  static Future<String> _loadFromAsset() async {
    return await rootBundle.loadString("assets/error_strings.json");
  }

  static Future<Map<String, dynamic>> _loadAndDecodeJson() async {
    String jsonString = await _loadFromAsset();
    return jsonDecode(jsonString);
  }

  static Future<String> getErrorMessage(String key) async {
    Map<String, dynamic> jsonMap = await _loadAndDecodeJson();
    return jsonMap["words"][key] ?? key;
  }
}
