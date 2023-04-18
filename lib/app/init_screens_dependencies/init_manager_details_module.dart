import 'package:get_it/get_it.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/dashboard_usecase/auth_usecase.dart';
import 'package:sasuki/domain/usecase/manager_actions_usecases/add_rewardpoints_manager_usecase.dart';
import 'package:sasuki/domain/usecase/manager_actions_usecases/deleted_manager_usecase.dart';
import 'package:sasuki/domain/usecase/manager_actions_usecases/deposit_manager_usecase.dart';
import 'package:sasuki/domain/usecase/manager_actions_usecases/renamed_manager_usecase.dart';
import 'package:sasuki/domain/usecase/manager_details_usecases/manager_details__overviewapi_usecase.dart';
import 'package:sasuki/presentation/manager_details/viewmodel/manager_details_viewmodel.dart';

initManagerDetailsModule() async {
  if (!GetIt.I.isRegistered<ManagerOverviewApiUseCase>()) {
    instance.registerFactory<ManagerOverviewApiUseCase>(
      () => ManagerOverviewApiUseCase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<DepositManagerUsecase>()) {
    instance.registerFactory<DepositManagerUsecase>(
      () => DepositManagerUsecase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<WithdrawManagerUsecase>()) {
    instance.registerFactory<WithdrawManagerUsecase>(
      () => WithdrawManagerUsecase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<RenamedManagerUseCase>()) {
    instance.registerFactory<RenamedManagerUseCase>(
      () => RenamedManagerUseCase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<DeletedManagerUseCase>()) {
    instance.registerFactory<DeletedManagerUseCase>(
      () => DeletedManagerUseCase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<AddRewardPointsManagerUseCase>()) {
    instance.registerFactory<AddRewardPointsManagerUseCase>(
      () => AddRewardPointsManagerUseCase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<AuthUseCase>()) {
    instance.registerFactory<AuthUseCase>(
      () => AuthUseCase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<ManagerDetailsViewModel>()) {
    // user details view model instance
    instance.registerLazySingleton<ManagerDetailsViewModel>(
      () => ManagerDetailsViewModel(
        instance<ManagerOverviewApiUseCase>(),
        instance<DepositManagerUsecase>(),
        instance<WithdrawManagerUsecase>(),
        instance<RenamedManagerUseCase>(),
        instance<DeletedManagerUseCase>(),
        instance<AuthUseCase>(),
      ),
    );
  }
}
