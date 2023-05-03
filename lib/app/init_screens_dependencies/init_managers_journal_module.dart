import 'package:get_it/get_it.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/captcha_usecase/captcha_usecase.dart';
import 'package:sasuki/domain/usecase/manager_journal_usecase/manager_journal_usecase.dart';
import 'package:sasuki/presentation/managers_journal/viewmodel/managers_journal_viewmodel.dart';

initManagersJournalModule() async {
  if (!GetIt.I.isRegistered<ManagerJournalUsecase>()) {
    instance.registerFactory<ManagerJournalUsecase>(
      () => ManagerJournalUsecase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<CaptchaUseCase>()) {
    instance.registerFactory<CaptchaUseCase>(
      () => CaptchaUseCase(instance<Repository>()),
    );
  }
  if (!GetIt.I.isRegistered<ManagersJournalViewModel>()) {
    // users list view model instance
    instance.registerLazySingleton<ManagersJournalViewModel>(
        () => ManagersJournalViewModel(
              instance<ManagerJournalUsecase>(),
              instance<CaptchaUseCase>(),
            ));
  }
}
