import 'package:get_it/get_it.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/acl_permission_group_list_usecase/acl_permission_group_list_usecase.dart';
import 'package:sasuki/domain/usecase/edit_manager_usecase/edit_manager_usecase.dart';
import 'package:sasuki/domain/usecase/managers_list_usecase/managers_list_usecase.dart';
import 'package:sasuki/presentation/edit_manager/viewmodel/edit_manager_viewmodel.dart';

initEditManagerModule() async {
  if (!GetIt.I.isRegistered<EditManagerUseCase>()) {
    instance.registerFactory<EditManagerUseCase>(
      () => EditManagerUseCase(instance<Repository>()),
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

  if (!GetIt.I.isRegistered<EditManagerViewModel>()) {
    // Edit UserViewModel instance
    instance.registerLazySingleton<EditManagerViewModel>(
      () => EditManagerViewModel(
        instance<EditManagerUseCase>(),
        instance<ManagersListUsecase>(),
        instance<AclPermissionGroupListUsecase>(),
      ),
    );
  }
}
