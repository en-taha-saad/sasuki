import 'package:sasuki/domain/models/filter_lists/parent_list.dart';
import 'package:sasuki/domain/models/filter_lists/profile_list.dart';

abstract class EditUserViewModelOutputs {
  Stream<bool> get outputIsUsernameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputAreAllInputsValid;
  Stream<List<ProfileData>> get outputProfileList;
  Stream<List<SingleParentData>> get outputParentList;
}
