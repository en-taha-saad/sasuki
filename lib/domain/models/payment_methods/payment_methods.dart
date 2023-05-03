class PaymentMethods {
  int? status;
  List<SinglePaymentMethod>? data;

  PaymentMethods(this.status, this.data);
}

class SinglePaymentMethod {
  int? id;
  String? name;
  String? country;
  String? internalName;

  SinglePaymentMethod(this.id, this.name, this.country, this.internalName);
}
