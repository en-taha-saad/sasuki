import 'package:sasuki/app/app_inits_funs/constants.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return Constants.emptyStr;
    } else {
      return this!;
    }
  }
}
