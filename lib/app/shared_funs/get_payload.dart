import 'dart:convert';

import 'package:sasuki/app/resources/local_libraries/aes_decryption.dart';

String getPayload(Map<String, dynamic> json) {
  String payload = AES.encrypt(
    data: jsonEncode(json),
    passpharse: 'abcdefghijuklmno0123456789012345',
  );
  return payload;
}
