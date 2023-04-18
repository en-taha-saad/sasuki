abstract class ManagerDetailsViewModelInputs {
  getManagerApiOverview(int managerId);
  depositAction(String amount, String comment, bool isLoan);
  withdrawAction(String amount, String comment);
  // payDebtAction(String amount, String comment);
  renameUsername(String newUsername);
  deleteManager(context);

  getManagerDataStreamingly();

  Sink get inputManagerApiOverview;
}
