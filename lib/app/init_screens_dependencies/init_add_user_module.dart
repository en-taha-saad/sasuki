import 'package:get_it/get_it.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/add_user_usecase/add_user_usecase.dart';
import 'package:sasuki/domain/usecase/filter_lists_usecase/parent_list.usecase.dart';
import 'package:sasuki/domain/usecase/filter_lists_usecase/profile_list.usecase.dart';
import 'package:sasuki/presentation/add_user/viewmodel/add_user_viewmodel.dart';

initAddUserModule() async {
  // activation api module, only users list screen dependencies are here
  // Add User UseCase
  if (!GetIt.I.isRegistered<AddUserUseCase>()) {
    instance.registerFactory<AddUserUseCase>(
      () => AddUserUseCase(instance<Repository>()),
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

  if (!GetIt.I.isRegistered<AddUserViewModel>()) {
    // Add UserViewModel instance
    instance.registerLazySingleton<AddUserViewModel>(
      () => AddUserViewModel(
        instance<AddUserUseCase>(),
        instance<ProfileListUseCase>(),
        instance<ParentListUseCase>(),
      ),
    );
  }
}
