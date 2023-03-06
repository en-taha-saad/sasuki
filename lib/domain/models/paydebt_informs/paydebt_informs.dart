class PaydebtInforms {
  int? status;
  PaydebtData? data;

  PaydebtInforms(this.status, this.data);
}

class PaydebtData {
  int? total;
  int? debtForMe;
  // String? username;
  // int? balance;

  PaydebtData(
    this.total,
    this.debtForMe,
    // this.username,
    // this.balance,
  );
}
