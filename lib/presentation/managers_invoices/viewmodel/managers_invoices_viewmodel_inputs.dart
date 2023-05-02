abstract class ManagersInvoicesViewModelInputs {
  Future getManagersInvoices();
  Future refreshManagersInvoices();
  Future getManagersInvoicesForPull();
  Future getNextManagersInvoices();
  Future getManagersInvoicesStreamingly();
  Sink get inputManagersInvoices;
}
