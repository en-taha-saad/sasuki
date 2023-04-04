import 'package:sasuki/domain/models/extend_user_informs/allowed_extersion_methods.dart';
import 'package:sasuki/domain/models/extend_user_informs/extend_user_informs.dart';

abstract class ExtendUserViewModelOutputs {
  Stream<ExtendUserInforms> get outputExtendUserInforms;
  Stream<AllowedExtersionMethods> get outputExtensionInforms;
}
