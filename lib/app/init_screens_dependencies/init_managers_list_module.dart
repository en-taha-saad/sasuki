import 'package:get_it/get_it.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/acl_permission_group_list_usecase/acl_permission_group_list_usecase.dart';
import 'package:sasuki/domain/usecase/dashboard_usecase/auth_usecase.dart';
import 'package:sasuki/domain/usecase/managers_list_details_usecase/managers_list_details_usecase.dart';
import 'package:sasuki/domain/usecase/managers_list_usecase/managers_list_usecase.dart';
import 'package:sasuki/presentation/managers_list/viewmodel/managers_list_viewmodel.dart';

initManagersListModule() async {
  if (!GetIt.I.isRegistered<ManagersListDetailsUsecase>()) {
    instance.registerFactory<ManagersListDetailsUsecase>(
      () => ManagersListDetailsUsecase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<ManagersListUsecase>()) {
    instance.registerFactory<ManagersListUsecase>(
      () => ManagersListUsecase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<AclPermissionGroupListUsecase>()) {
    instance.registerFactory<AclPermissionGroupListUsecase>(
      () => AclPermissionGroupListUsecase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<AuthUseCase>()) {
    instance.registerFactory<AuthUseCase>(
      () => AuthUseCase(instance<Repository>()),
    );
  }
  if (!GetIt.I.isRegistered<ManagersListViewModel>()) {
    // users list view model instance
    instance.registerLazySingleton<ManagersListViewModel>(
        () => ManagersListViewModel(
              instance<ManagersListDetailsUsecase>(),
              instance<ManagersListUsecase>(),
              instance<AclPermissionGroupListUsecase>(),
              instance<AuthUseCase>(),
            ));
  }
}
