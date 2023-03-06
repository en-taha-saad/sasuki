
import 'dart:convert';

import 'package:flutter/foundation.dart';

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}