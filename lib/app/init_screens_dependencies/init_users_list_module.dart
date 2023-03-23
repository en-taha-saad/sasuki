import 'package:get_it/get_it.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/filter_lists_usecase/parent_list.usecase.dart';
import 'package:sasuki/domain/usecase/filter_lists_usecase/profile_list.usecase.dart';
import 'package:sasuki/domain/usecase/users_list_usecase/users_list.usecase.dart';
import 'package:sasuki/presentation/users_list/viewmodel/users_list_viewmodel.dart';

initUsersListModule() async {
  // users list module, only users list screen dependencies are here
  // shared preferences instance
  if (!GetIt.I.isRegistered<UsersListUseCase>()) {
    instance.registerFactory<UsersListUseCase>(
      () => UsersListUseCase(instance<Repository>()),
    );
  }

  // parent list module, only users list screen dependencies are here
  // shared preferences instance
  if (!GetIt.I.isRegistered<ParentListUseCase>()) {
    instance.registerFactory<ParentListUseCase>(
      () => ParentListUseCase(instance<Repository>()),
    );
  }
  // profile list module, only users list screen dependencies are here
  // shared preferences instance
  if (!GetIt.I.isRegistered<ProfileListUseCase>()) {
    instance.registerFactory<ProfileListUseCase>(
      () => ProfileListUseCase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<UsersListViewModel>()) {
    // users list view model instance
    instance.registerLazySingleton<UsersListViewModel>(() => UsersListViewModel(
          instance<UsersListUseCase>(),
          instance<ParentListUseCase>(),
          instance<ProfileListUseCase>(),
        ));
  }
}
