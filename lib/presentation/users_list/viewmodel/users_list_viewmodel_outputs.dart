import 'package:sasuki/domain/models/filter_lists/connection_list.dart';
import 'package:sasuki/domain/models/filter_lists/parent_list.dart';
import 'package:sasuki/domain/models/filter_lists/profile_list.dart';
import 'package:sasuki/domain/models/filter_lists/status_list.dart';
import 'package:sasuki/domain/models/users_list/users_list.dart';

abstract class UsersListViewModelOutputs {
  Stream<UsersList> get outputUsersListData;
  Stream<List<UsersListData>?> get outputUsersList;
  Stream<List<SingleParentData>> get outputParentList;
  Stream<List<StatusFilterList>> get outputStatusList;
  Stream<List<ConnectionFilterList>> get outputConnectionList;
  Stream<List<ProfileData>> get outputProfileList;
  Stream<bool> get outputIsSearchInputValid;
}
