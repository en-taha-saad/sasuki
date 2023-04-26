class ManagerJournal {
  List<ManagerJournalData>? data;
  int? total;

  ManagerJournal(this.data, this.total);
}

class ManagerJournalData {
  int? id;
  String? amount;
  String? createdAt;
  String? credit;
  String? debt;
  String? operation;
  String? description;
  String? comment;
  String? balance;

  ManagerJournalData(
    this.id,
    this.amount,
    this.createdAt,
    this.description,
    this.comment,
    this.balance,
    this.credit,
    this.debt,
    this.operation,
  );
}
