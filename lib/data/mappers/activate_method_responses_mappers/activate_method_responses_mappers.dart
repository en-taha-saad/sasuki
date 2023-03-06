import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/activate_method_responses/activate_method_responses.dart';
import 'package:sasuki/domain/models/activate_method/activate_method.dart';

extension ActivateMethodResponseMapper on ActivateMethodResponse? {
  ActivateMethod toDomain() {
    return ActivateMethod(
      this?.status.orZero(),
      this?.message.orEmpty(),
    );
  }
}
