// inputs mean that "Orders" that our view model will receive from view
abstract class ChooseServerViewModelInputs {
  // stream controller input
  Sink get inputListOfServers;
  Sink get inputIsNotSelectedServer;
  Sink get inputSelectedServer;
  Sink get inputIsSelectedServer;
}
