class ManagersInvoices {
  List<ManagersInvoiceData>? data;
  int? total;

  ManagersInvoices(this.data, this.total);
}

class ManagersInvoiceData {
  int? id;
  String? invoiceNumber;
  String? type;
  String? amount;
  String? createdAt;
  IssuerDetails? issuerDetails;
  String? description;
  String? paid;
  String? paymentMethod;
  String? comments;
  OwnerDetails? ownerDetails;

  ManagersInvoiceData(
    this.id,
    this.invoiceNumber,
    this.type,
    this.amount,
    this.createdAt,
    this.issuerDetails,
    this.description,
    this.paid,
    this.paymentMethod,
    this.comments,
    this.ownerDetails,
  );
}

class IssuerDetails {
  int? id;
  String? username;

  IssuerDetails(this.id, this.username);
}

class OwnerDetails {
  int? id;
  String? username;

  OwnerDetails(this.id, this.username);
}
