class ManagerListDetails {
  List<SingleManagerDetails>? data;
  int? total;

  ManagerListDetails(this.data, this.total);
}

class SingleManagerDetails {
  int? id;
  String? username;
  String? firstname;
  String? lastname;
  AclGroupDetails? aclGroupDetails;
  double? balance;
  int? enabled;

  SingleManagerDetails(
    this.id,
    this.username,
    this.firstname,
    this.lastname,
    this.aclGroupDetails,
    this.balance,
    this.enabled,
  );
}

class AclGroupDetails {
  int? id;
  String? name;
  int? dashboardId;

  AclGroupDetails(this.id, this.name, this.dashboardId);
}
