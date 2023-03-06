import 'package:sasuki/app/extensions/non_null_double.dart';
import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/manager_list_details_responses/manager_list_details_responses.dart';
import 'package:sasuki/domain/models/manager_list_details/manager_list_details.dart';

extension ManagerListDetailsResponsesMapper on ManagerListDetailsResponses? {
  ManagerListDetails toDomain() {
    return ManagerListDetails(
      this?.data?.map((e) => e.toDomain()).toList(),
      this?.total.orZero(),
    );
  }
}

extension SingleManagerDetailsResponsesMapper
    on SingleManagerDetailsResponses? {
  SingleManagerDetails toDomain() {
    return SingleManagerDetails(
      this?.id.orZero(),
      this?.username.orEmpty(),
      this?.firstname.orEmpty(),
      this?.lastname.orEmpty(),
      this?.aclGroupDetails?.toDomain(),
      this?.balance.orZeroDouble() ?? 0,
      this?.enabled.orZero(),
    );
  }
}

extension AclGroupDetailsResponsesMapper on AclGroupDetailsResponses? {
  AclGroupDetails toDomain() {
    return AclGroupDetails(
      this?.id.orZero(),
      this?.name.orEmpty(),
      this?.dashboardId.orZero(),
    );
  }
}
