class ManagerOverviewApi {
  ManagerOverviewData? data;
  int? status;

  ManagerOverviewApi(this.data, this.status);
}

class ManagerOverviewData {
  String? username;
  String? firstname;
  String? lastname;
  String? aclGroupName;
  String? createdAt;
  int? balance;
  int? rewardPoints;
  int? status;
  int? users;
  int? activeUsers;
  int? expiredUsers;
  String? phone;
  String? parentUsername;
  int? debts;

  ManagerOverviewData(
    this.username,
    this.firstname,
    this.lastname,
    this.aclGroupName,
    this.createdAt,
    this.balance,
    this.rewardPoints,
    this.status,
    this.users,
    this.activeUsers,
    this.expiredUsers,
    this.phone,
    this.parentUsername,
    this.debts,
  );
}
