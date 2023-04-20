import 'package:get_it/get_it.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/acl_permission_group_list_usecase/acl_permission_group_list_usecase.dart';
import 'package:sasuki/domain/usecase/add_manager_usecase/add_manager_usecase.dart';
import 'package:sasuki/domain/usecase/managers_list_usecase/managers_list_usecase.dart';
import 'package:sasuki/presentation/add_manager/viewmodel/add_manager_viewmodel.dart';

initAddManagerModule() async {
  if (!GetIt.I.isRegistered<AddManagerUseCase>()) {
    instance.registerFactory<AddManagerUseCase>(
      () => AddManagerUseCase(instance<Repository>()),
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

  if (!GetIt.I.isRegistered<AddManagerViewModel>()) {
    // Edit UserViewModel instance
    instance.registerLazySingleton<AddManagerViewModel>(
      () => AddManagerViewModel(
        instance<AddManagerUseCase>(),
        instance<ManagersListUsecase>(),
        instance<AclPermissionGroupListUsecase>(),
      ),
    );
  }
}
