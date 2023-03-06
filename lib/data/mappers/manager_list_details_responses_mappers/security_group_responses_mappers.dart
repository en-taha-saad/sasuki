import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/manager_list_details_responses/security_group_responses.dart';
import 'package:sasuki/domain/models/manager_list_details/security_group.dart';

extension SecurityGroupResponsesMapper on SecurityGroupResponses? {
  SecurityGroup toDomain() {
    return SecurityGroup(
      this?.data?.map((e) => e.toDomain()).toList(),
      this?.status.orZero(),
    );
  }
}

extension SingleACLResponsesMapper on SingleACLResponses? {
  SingleACL toDomain() {
    return SingleACL(
      this?.id.orZero(),
      this?.name.orEmpty(),
      this?.dashboardId.orZero(),
    );
  }
}
