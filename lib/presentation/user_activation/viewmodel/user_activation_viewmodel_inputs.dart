import 'package:sasuki/domain/models/activation_informs/activation_method.dart';

abstract class UserActivationViewModelInputs {
  getActivationInforms(int userId);
  getActivationInformsStreamingly(int userId);
  activateUser(
    ActivationMethod? selectedActivationMethod,
    bool isMoneyCollected,
    int? userPrice,
  );
  setPin(String pin);
  setComment(String comment);

  Sink get inputActivationInforms;
}
