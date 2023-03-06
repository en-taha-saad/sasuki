import 'package:sasuki/app/app_inits_funs/constants.dart';

extension NonNullDouble on double? {
  double orZeroDouble() {
    if (this == null) {
      return Constants.zeroDouble;
    } else {
      return this!;
    }
  }
}
