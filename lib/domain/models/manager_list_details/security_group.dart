class SecurityGroup {
  List<SingleACL>? data;
  int? status;

  SecurityGroup(this.data, this.status);
}

class SingleACL {
  int? id;
  String? name;
  int? dashboardId;

  SingleACL(this.id, this.name, this.dashboardId);
}
