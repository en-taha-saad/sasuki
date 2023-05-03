abstract class DepositScreenModelInputs {
  setAmount(String amount);
  setPin(String pin);

  Sink get inputIsAmountEntered;
  Sink get inputIsPinEntered;
  Sink get inputAmount;
  Sink get inputPin;

  Future getPaymentMethodList();

  Sink get inputPaymentMethodList;

  depositPayment();
}
