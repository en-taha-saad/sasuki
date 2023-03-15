import 'package:get_it/get_it.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/captcha_usecase/captcha_usecase.dart';
import 'package:sasuki/domain/usecase/dashboard_usecase/auth_usecase.dart';
import 'package:sasuki/domain/usecase/dashboard_usecase/dashboarddata_usecase.dart';
import 'package:sasuki/domain/usecase/servers_usecase/selected_server_usecase.dart';
import 'package:sasuki/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';

initDashboardModule() async {
  // dashboard module, only login dependencies are here
  // shared preferences instance
  if (!GetIt.I.isRegistered<DashboardUseCase>()) {
    instance.registerFactory<DashboardUseCase>(
      () => DashboardUseCase(instance<Repository>()),
    );
  }
  if (!GetIt.I.isRegistered<SelectedServerUsecase>()) {
    instance.registerFactory<SelectedServerUsecase>(
      () => SelectedServerUsecase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<AuthUseCase>()) {
    instance.registerFactory<AuthUseCase>(
      () => AuthUseCase(instance<Repository>()),
    );
  }
  if (!GetIt.I.isRegistered<CaptchaUseCase>()) {
    instance.registerFactory<CaptchaUseCase>(
      () => CaptchaUseCase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<DashboardViewModel>()) {
    // dashboard view model instance
    instance.registerLazySingleton<DashboardViewModel>(() => DashboardViewModel(
          instance<AuthUseCase>(),
          instance<DashboardUseCase>(),
          instance<CaptchaUseCase>(),
          instance<SelectedServerUsecase>(),
        ));
  }
}
