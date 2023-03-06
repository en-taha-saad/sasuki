import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt_lib;
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';

class AES {
  static String encrypt({String? data, String? passpharse}) {
    try {
      var salt = [1, 2, 3, 4, 5, 6, 7, 8];

      List<int> salted = [];
      List<int> dx = [];
      while (salted.length < 48) {
        dx = generateMd5(dx + utf8.encode(passpharse!) + salt.toList());
        salted = salted + dx;
      }

      var key = salted.sublist(0, 32);
      var iv = salted.sublist(32);

      // encrypt part
      final kkey = encrypt_lib.Key(Uint8List.fromList(key));
      final iiv = encrypt_lib.IV(Uint8List.fromList(iv));

      final encrypter = encrypt_lib.Encrypter(
        encrypt_lib.AES(
          kkey,
          mode: encrypt_lib.AESMode.cbc,
        ),
      );
      final encrypted = encrypter.encrypt(
        data!,
        iv: iiv,
      );
      var aesEncode = encrypted.bytes;
      String encoded = base64
          .encode(utf8.encode("Salted__") + salt.toList() + aesEncode.toList());
      return encoded;
    } catch (e) {
      return '';
    }
  }

  static List<int> generateMd5(List<int> input) {
    return md5.convert(input).bytes;
  }
}
