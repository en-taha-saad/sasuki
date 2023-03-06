class ActivateRequest {
  String? method;
  String? pin;
  String? userId;
  int? moneyCollected;
  String? comments;
  int? userPrice;
  bool? issueInvoice;
  String? transactionId;
  int? activationUnits;

  ActivateRequest(
    this.method,
    this.pin,
    this.userId,
    this.moneyCollected,
    this.comments,
    this.userPrice,
    this.issueInvoice,
    this.transactionId,
    this.activationUnits,
  );

  ActivateRequest.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    pin = json['pin'];
    userId = json['user_id'];
    moneyCollected = json['money_collected'];
    comments = json['comments'];
    userPrice = json['user_price'];
    issueInvoice = json['issue_invoice'];
    transactionId = json['transaction_id'];
    activationUnits = json['activation_units'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['method'] = method;
    data['pin'] = pin;
    data['user_id'] = userId;
    data['money_collected'] = moneyCollected;
    data['comments'] = comments;
    data['user_price'] = userPrice;
    data['issue_invoice'] = issueInvoice;
    data['transaction_id'] = transactionId;
    data['activation_units'] = activationUnits;
    return data;
  }
}
