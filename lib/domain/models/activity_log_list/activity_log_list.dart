class ActivityLogList {
  List<ActivityLog?>? data;
  int? total;

  ActivityLogList(this.data, this.total);
}

class ActivityLog {
  int? id;
  String? createdAt;
  int? createdBy;
  String? event;
  String? description;
  String? ip;
  ManagerDetails? managerDetails;

  ActivityLog(
    this.id,
    this.createdAt,
    this.createdBy,
    this.event,
    this.description,
    this.ip,
    this.managerDetails,
  );
}

class ManagerDetails {
  int? id;
  String? username;
  String? firstName;
  String? lastName;

  ManagerDetails(this.id, this.username, this.firstName, this.lastName);
}
