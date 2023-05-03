abstract class ManagersJournalViewModelInputs {
  Future getManagersJournal();
  Future refreshManagersJournal();
  Future getManagersJournalForPull();
  Future getNextManagersJournal();
  Future getManagersJournalStreamingly();
  Sink get inputManagersJournal;
}
