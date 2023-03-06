import 'package:sasuki/app/app_inits_funs/constants.dart';

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return Constants.zeroNum.toInt();
    } else {
      return this!;
    }
  }
}
