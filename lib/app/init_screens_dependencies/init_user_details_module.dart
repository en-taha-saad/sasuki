import 'package:get_it/get_it.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/dashboard_usecase/auth_usecase.dart';
import 'package:sasuki/domain/usecase/deposit_usecase/deposit_usecase.dart';
import 'package:sasuki/domain/usecase/deposit_usecase/withdraw_usecase.dart';
import 'package:sasuki/domain/usecase/paydebt_usecases/paydebt_informs_usecase.dart';
import 'package:sasuki/domain/usecase/paydebt_usecases/paydebt_method_usecase.dart';
import 'package:sasuki/domain/usecase/user_actions_usecases/change_user_profile_usecase.dart';
import 'package:sasuki/domain/usecase/user_actions_usecases/deleted_user_usecase.dart';
import 'package:sasuki/domain/usecase/filter_lists_usecase/profile_list.usecase.dart';
import 'package:sasuki/domain/usecase/user_actions_usecases/renamed_user_usecase.dart';
import 'package:sasuki/domain/usecase/user_details_usecases/user_details__overviewapi_usecase.dart';
import 'package:sasuki/domain/usecase/user_details_usecases/user_details_api_usecase.dart';
import 'package:sasuki/presentation/user_details/viewmodel/user_details_viewmodel.dart';

initUserDetailsModule() async {
  // user overview api module, only users list screen dependencies are here
  // shared preferences instance
  if (!GetIt.I.isRegistered<UserOverviewApiUseCase>()) {
    instance.registerFactory<UserOverviewApiUseCase>(
      () => UserOverviewApiUseCase(instance<Repository>()),
    );
  }

  // user api module, only users list screen dependencies are here
  // shared preferences instance
  if (!GetIt.I.isRegistered<UserApiUseCase>()) {
    instance.registerFactory<UserApiUseCase>(
      () => UserApiUseCase(instance<Repository>()),
    );
  }

  // auth api module, only users list screen dependencies are here
  // shared preferences instance
  if (!GetIt.I.isRegistered<AuthUseCase>()) {
    instance.registerFactory<AuthUseCase>(
      () => AuthUseCase(instance<Repository>()),
    );
  }

  // deleted user api module, only users list screen dependencies are here
  // shared preferences instance
  if (!GetIt.I.isRegistered<DeletedUserUseCase>()) {
    instance.registerFactory<DeletedUserUseCase>(
      () => DeletedUserUseCase(instance<Repository>()),
    );
  }

  // renamed user api module, only users list screen dependencies are here
  // shared preferences instance
  if (!GetIt.I.isRegistered<RenamedUserUseCase>()) {
    instance.registerFactory<RenamedUserUseCase>(
      () => RenamedUserUseCase(instance<Repository>()),
    );
  }

  // profile list api module, only users list screen dependencies are here
  // shared preferences instance
  if (!GetIt.I.isRegistered<ProfileListUseCase>()) {
    instance.registerFactory<ProfileListUseCase>(
      () => ProfileListUseCase(instance<Repository>()),
    );
  }

  // change user profile module, only users list screen dependencies are here
  // shared preferences instance
  if (!GetIt.I.isRegistered<ChangeUserProfileUseCase>()) {
    instance.registerFactory<ChangeUserProfileUseCase>(
      () => ChangeUserProfileUseCase(instance<Repository>()),
    );
  }

  // deposit module, only users list screen dependencies are here
  // shared preferences instance
  if (!GetIt.I.isRegistered<DepositUsecase>()) {
    instance.registerFactory<DepositUsecase>(
      () => DepositUsecase(instance<Repository>()),
    );
  }

  // withdraw module, only users list screen dependencies are here
  // shared preferences instance
  if (!GetIt.I.isRegistered<WithdrawUsecase>()) {
    instance.registerFactory<WithdrawUsecase>(
      () => WithdrawUsecase(instance<Repository>()),
    );
  }

  // paydebt module, only users list screen dependencies are here
  // shared preferences instance
  if (!GetIt.I.isRegistered<PaydebtUseCase>()) {
    instance.registerFactory<PaydebtUseCase>(
      () => PaydebtUseCase(instance<Repository>()),
    );
  }

  // paydebt Informs module, only users list screen dependencies are here
  // shared preferences instance
  if (!GetIt.I.isRegistered<PayDebtInformsUsecase>()) {
    instance.registerFactory<PayDebtInformsUsecase>(
      () => PayDebtInformsUsecase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<UserDetailsViewModel>()) {
    // user details view model instance
    instance.registerLazySingleton<UserDetailsViewModel>(
      () => UserDetailsViewModel(
        instance<UserOverviewApiUseCase>(),
        instance<AuthUseCase>(),
        instance<DeletedUserUseCase>(),
        instance<RenamedUserUseCase>(),
        instance<ProfileListUseCase>(),
        instance<ChangeUserProfileUseCase>(),
        instance<DepositUsecase>(),
        instance<WithdrawUsecase>(),
        instance<PaydebtUseCase>(),
        instance<PayDebtInformsUsecase>(),
      ),
    );
  }
}
