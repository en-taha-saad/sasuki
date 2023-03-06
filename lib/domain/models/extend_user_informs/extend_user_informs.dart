class ExtendUserInforms {
  ExtendUser? data;
  int? status;

  ExtendUserInforms(this.data, this.status);
}

class ExtendUser {
  // String? remainingRxtx;
  // String? remainingRx;
  // String? remainingTx;
  // String? remainingUptime;
  String? expiration;
  String? profileName;
  // int? profileId;
  String? username;
  String? balance;
  String? userBalance;
  int? rewardPoints;
  // String? rewardPointsBalance;
  // int? requiredPoints;

  ExtendUser(
    // this.remainingRxtx,
    // this.remainingRx,
    // this.remainingTx,
    // this.remainingUptime,
    this.expiration,
    this.profileName,
    // this.profileId,
    this.username,
    this.balance,
    this.userBalance,
    // this.rewardPointsBalance,
    this.rewardPoints,
    // this.requiredPoints,
  );
}
