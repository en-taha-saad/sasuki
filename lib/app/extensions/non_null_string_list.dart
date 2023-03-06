import 'package:sasuki/app/app_inits_funs/constants.dart';

extension NonNullList on List<String>? {
  List<String> orEmptyStringList() {
    // ignore: prefer_is_empty
    if (this == null && this?.length == 0) {
      return Constants.emptyList;
    } else {
      return this!;
    }
  }
}
