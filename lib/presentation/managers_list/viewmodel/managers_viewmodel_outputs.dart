import 'package:sasuki/domain/models/managers_list/managers_list.dart'
    as managers_list;
import 'package:sasuki/domain/models/manager_list_details/manager_list_details.dart';

abstract class ManagersListViewModelOutputs {
  Stream<ManagerListDetails> get outputManagersListData;
  Stream<List<SingleManagerDetails>?> get outputManagersList;
  Stream<List<managers_list.SingleManagerData>> get outputParentManagerList;
  Stream<bool> get outputIsSearchInputValid;
}
