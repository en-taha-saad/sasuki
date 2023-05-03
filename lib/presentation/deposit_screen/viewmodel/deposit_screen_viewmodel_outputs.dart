import 'package:sasuki/domain/models/payment_methods/payment_methods.dart';

abstract class DepositScreenModelOutputs {
  Stream<bool> get outputIsAmountEntered;
  Stream<bool> get outputIsPinEntered;
  Stream<PaymentMethods> get outputPaymentMethodList;
  Stream<String> get outputAmount;
  Stream<String> get outputPin;
}
