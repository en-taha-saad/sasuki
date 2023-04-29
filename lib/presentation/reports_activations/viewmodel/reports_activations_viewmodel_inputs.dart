abstract class ReportsActivationsViewModelInputs {
  Future getReportsActivations();
  Future refreshReportsActivations();
    Future getFilteredActivationsList();

  Future getReportsActivationsForPull();
  Future getNextReportsActivations();
  Future getProfileList();
  Future getActivationsReportsStreamingly();
  Sink get inputReportsActivations;
  Sink get inputProfileList;
}
