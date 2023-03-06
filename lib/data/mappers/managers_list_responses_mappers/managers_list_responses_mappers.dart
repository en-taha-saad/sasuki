import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/managers_list_responses/managers_list_responses.dart';
import 'package:sasuki/domain/models/managers_list/managers_list.dart';

extension ManagersListResponsesMapper on ManagersListResponses? {
  ManagersList toDomain() {
    return ManagersList(
      this?.i0.orZero(),
      this?.data?.map((e) => e.toDomain()).toList(),
    );
  }
}

extension SingleManagerDataResponsesMapper on SingleManagerDataResponses? {
  SingleManagerData toDomain() {
    return SingleManagerData(
      this?.id.orZero(),
      this?.username.orEmpty(),
    );
  }
}
