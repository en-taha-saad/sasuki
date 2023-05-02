import 'package:get_it/get_it.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/captcha_usecase/captcha_usecase.dart';
import 'package:sasuki/domain/usecase/manager_invoices_usecase/manager_invoices_usecase.dart';
import 'package:sasuki/presentation/managers_invoices/viewmodel/managers_invoices_viewmodel.dart';

initManagersInvoicesModule() async {
  if (!GetIt.I.isRegistered<ManagerInvoicesUsecase>()) {
    instance.registerFactory<ManagerInvoicesUsecase>(
      () => ManagerInvoicesUsecase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<CaptchaUseCase>()) {
    instance.registerFactory<CaptchaUseCase>(
      () => CaptchaUseCase(instance<Repository>()),
    );
  }
  if (!GetIt.I.isRegistered<ManagersInvoicesViewModel>()) {
    // users list view model instance
    instance.registerLazySingleton<ManagersInvoicesViewModel>(
        () => ManagersInvoicesViewModel(
              instance<ManagerInvoicesUsecase>(),
              instance<CaptchaUseCase>(),
            ));
  }
}
