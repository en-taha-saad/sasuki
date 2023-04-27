import 'package:get_it/get_it.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/activations_reports_usecase/activations_reports_usecase.dart';
import 'package:sasuki/domain/usecase/filter_lists_usecase/profile_list.usecase.dart';
import 'package:sasuki/presentation/reports_activations/viewmodel/reports_activations_viewmodel.dart';

initReportsActivationsModule() async {
  // profile list module, only users list screen dependencies are here
  // shared preferences instance
  if (!GetIt.I.isRegistered<ProfileListUseCase>()) {
    instance.registerFactory<ProfileListUseCase>(
      () => ProfileListUseCase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<ActivationsReportsUsecase>()) {
    instance.registerFactory<ActivationsReportsUsecase>(
      () => ActivationsReportsUsecase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<ReportsActivationsViewModel>()) {
    // users list view model instance
    instance.registerLazySingleton<ReportsActivationsViewModel>(
        () => ReportsActivationsViewModel(
              instance<ActivationsReportsUsecase>(),
              instance<ProfileListUseCase>(),
            ));
  }
}
