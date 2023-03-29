import 'package:sasuki/domain/models/filter_lists/profile_list.dart';
import 'package:sasuki/domain/models/user_details/user_overview_api.dart';

abstract class UserDetailsViewModelOutputs {
  Stream<UserOverviewApi> get outputUserOverviewApi;
  Stream<List<ProfileData>> get outputProfileList;
}
