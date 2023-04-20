class ManagerDetails {
  ManagerDetailsData? data;
  int? status;

  ManagerDetails(this.data, this.status);
}

class ManagerDetailsData {
  int? id;
  String? username;
  int? enabled;
  String? city;
  String? country;
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  String? company;
  String? address;
  int? balance;
  String? notes;
  int? managerId;
  int? maxUsers;
  String? createdAt;
  String? deletedAt;
  int? aclGroupId;
  int? parentId;
  int? createdBy;

  ManagerDetailsData(
    this.id,
    this.username,
    this.enabled,
    this.city,
    this.country,
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.company,
    this.address,
    this.balance,
    this.notes,
    this.managerId,
    this.maxUsers,
    this.createdAt,
    this.deletedAt,
    this.aclGroupId,
    this.parentId,
    this.createdBy,
  );
}
