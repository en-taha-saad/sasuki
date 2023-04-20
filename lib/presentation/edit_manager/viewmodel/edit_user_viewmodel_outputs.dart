import 'package:sasuki/domain/models/acl_permission_group_list/acl_permission_group_list.dart';
import 'package:sasuki/domain/models/manager_details/manager_details.dart';
import 'package:sasuki/domain/models/managers_list/managers_list.dart'
    as managers_list;

abstract class EditManagerViewModelOutputs {
  Stream<bool> get outputIsUsernameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsFirstNameValid;
  Stream<bool> get outputIsLastNameValid;
  Stream<bool> get outputAreAllInputsValid;
  Stream<ManagerDetails> get outputManagerDetails;

  Stream<List<managers_list.SingleManagerData>> get outputParentManagerList;
  Stream<List<SingleAclPermissionGroup>> get outputAclPermissionGroupList;
}
