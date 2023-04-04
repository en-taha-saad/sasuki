import 'package:sasuki/domain/models/activation_informs/activation_informs.dart';

abstract class UserActivationViewModelOutputs {
  Stream<ActivationInforms> get outputActivationInforms;
}
