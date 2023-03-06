import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/extend_user_informs_responses/allowed_extersion_methods_responses.dart';
import 'package:sasuki/domain/models/extend_user_informs/allowed_extersion_methods.dart';

extension AllowedExtersionMethodsResponsesMapper
    on AllowedExtersionMethodsResponses? {
  AllowedExtersionMethods toDomain() {
    return AllowedExtersionMethods(
      this?.i0.orZero(),
      this?.status.orZero(),
      this?.data?.map((extensionMethod) => extensionMethod.toDomain()).toList(),
    );
  }
}

extension ExtensionResponseMapper on ExtensionResponse? {
  Extension toDomain() {
    return Extension(
      this?.id.orZero(),
      this?.name.orEmpty(),
      // this?.price.orEmpty(),
    );
  }
}
