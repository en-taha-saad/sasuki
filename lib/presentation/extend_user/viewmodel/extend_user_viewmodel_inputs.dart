import 'package:sasuki/domain/models/activation_informs/activation_method.dart';

abstract class ExtendUserViewModelInputs {
  getExtendUserInforms(int userId);
  getExtendUserInformsStreamingly(int userId);
  extendUser(ActivationMethod? selectedActivationMethod, int extensionId);
  getExtensionsInforms(int profileId);
  Sink get inputExtendUserInforms;
  Sink get inputExtensionInforms;
}
