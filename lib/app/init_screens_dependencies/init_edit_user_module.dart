import 'package:get_it/get_it.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/edit_user_usecase/edit_user_usecase.dart';
import 'package:sasuki/domain/usecase/filter_lists_usecase/parent_list.usecase.dart';
import 'package:sasuki/domain/usecase/filter_lists_usecase/profile_list.usecase.dart';
import 'package:sasuki/presentation/edit_user/viewmodel/edit_user_viewmodel.dart';

initEditUserModule() async {
  // activation api module, only users list screen dependencies are here
  // Edit User UseCase
  if (!GetIt.I.isRegistered<EditUserUseCase>()) {
    instance.registerFactory<EditUserUseCase>(
      () => EditUserUseCase(instance<Repository>()),
    );
  }
  // parent list UseCase
  if (!GetIt.I.isRegistered<ParentListUseCase>()) {
    instance.registerFactory<ParentListUseCase>(
      () => ParentListUseCase(instance<Repository>()),
    );
  }

  // profile list UseCase
  if (!GetIt.I.isRegistered<ProfileListUseCase>()) {
    instance.registerFactory<ProfileListUseCase>(
      () => ProfileListUseCase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<EditUserViewModel>()) {
    // Edit UserViewModel instance
    instance.registerLazySingleton<EditUserViewModel>(
      () => EditUserViewModel(
        instance<EditUserUseCase>(),
        instance<ProfileListUseCase>(),
        instance<ParentListUseCase>(),
      ),
    );
  }
}
