import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/acl_permission_group_list_responses/acl_permission_group_list_responses.dart';
import 'package:sasuki/domain/models/acl_permission_group_list/acl_permission_group_list.dart';

extension AclPermissionGroupListResponsesMapper
    on AclPermissionGroupListResponses? {
  AclPermissionGroupList toDomain() {
    return AclPermissionGroupList(
      this?.status.orZero(),
      this?.data?.map((e) => e.toDomain()).toList(),
    );
  }
}

extension SingleAclPermissionGroupResponsesMapper
    on SingleAclPermissionGroupResponses? {
  SingleAclPermissionGroup toDomain() {
    return SingleAclPermissionGroup(
      this?.id.orZero(),
      this?.name?.orEmpty(),
      this?.dashboardId.orZero(),
    );
  }
}
