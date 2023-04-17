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
  int? balance;
  int? enabled;
  int? usersCount;
  AclGroupDetails? aclGroupDetails;

  SingleManagerDetails(
    this.id,
    this.username,
    this.firstname,
    this.lastname,
    this.balance,
    this.enabled,
    this.usersCount,
    this.aclGroupDetails,
  );
}

class AclGroupDetails {
  int? id;
  String? name;
  int? dashboardId;

  AclGroupDetails(this.id, this.name, this.dashboardId);
}
