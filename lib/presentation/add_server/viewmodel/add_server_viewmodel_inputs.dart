// inputs mean that "Orders" that our view model will receive from view
abstract class AddServerViewModelInputs {
  // stream controller input
  setIspName(String ispName);
  setHostName(String hostName);
  // stream controller input
  Sink get inputIspName;
  Sink get inputHostName;
  Sink get inputAreAllInputsValid;
}
