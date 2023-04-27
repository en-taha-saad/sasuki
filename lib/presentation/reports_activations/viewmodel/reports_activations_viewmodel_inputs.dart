abstract class ReportsActivationsViewModelInputs {
  Future getReportsActivations();
  Future getReportsActivationsForPull();
  Future getNextReportsActivations();
  Future getProfileList();
  Future getActivationsReportsStreamingly();
  Sink get inputReportsActivations;
  Sink get inputProfileList;
}
