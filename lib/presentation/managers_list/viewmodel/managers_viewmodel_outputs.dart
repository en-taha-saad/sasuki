import 'package:sasuki/domain/models/filter_lists/connection_list.dart';
import 'package:sasuki/domain/models/filter_lists/parent_list.dart';
import 'package:sasuki/domain/models/filter_lists/profile_list.dart';
import 'package:sasuki/domain/models/filter_lists/status_list.dart';
import 'package:sasuki/domain/models/Managers_list/Managers_list.dart';
import 'package:sasuki/domain/models/manager_list_details/manager_list_details.dart';

abstract class ManagersListViewModelOutputs {
  Stream<ManagersList> get outputManagersListData;
  Stream<ManagerListDetails> get outputManagersList;
  Stream<List<SingleParentData>> get outputParentList;
  Stream<bool> get outputIsSearchInputValid;
}
