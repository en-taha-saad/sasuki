import 'package:sasuki/app/app_inits_funs/constants.dart';

extension NonNullBoolean on bool? {
  bool orFalse() {
    if (this == null) {
      return Constants.falseBool;
    } else {
      return this!;
    }
  }
}
