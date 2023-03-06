class UserOverviewApi {
  UserOverviewData? data;
  int? status;

  UserOverviewApi(this.data, this.status);
}

class UserOverviewData {
  String? username;
  String? parentUsername;
  String? profileName;
  int? profileId;
  String? expiration;
  bool? status;
  // String? createdAt;
  // String? createdBy;
  // int? balance;
  String? password;
  String? firstname;
  String? lastname;
  String? phone;
  // String? address;
  // String? city;
  String? email;
  int? remainingRx;
  int? remainingTx;
  int? remainingRxtx;
  int? remainingUptime;
  // bool? nextProfileChange;
  // int? pinTries;
  String? lastOnline;
  // List<String>? addons;

  UserOverviewData(
    this.username,
    this.parentUsername,
    this.profileName,
    this.profileId,
    this.expiration,
    this.status,
    // this.createdAt,
    // this.createdBy,
    // this.balance,
    this.password,
    this.firstname,
    this.lastname,
    this.phone,
    // this.address,
    // this.city,
    this.email,
    this.remainingRx,
    this.remainingTx,
    this.remainingRxtx,
    this.remainingUptime,
    // this.nextProfileChange,
    // this.pinTries,
    this.lastOnline,
    // this.addons,
  );
}
