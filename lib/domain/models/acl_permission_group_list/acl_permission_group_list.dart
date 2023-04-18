class AclPermissionGroupList {
  int? status;
  List<SingleAclPermissionGroup>? data;

  AclPermissionGroupList(this.status, this.data);
}

class SingleAclPermissionGroup {
  int? id;
  String? name;
  int? dashboardId;

  SingleAclPermissionGroup(this.id, this.name, this.dashboardId);
}
