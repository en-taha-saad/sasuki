import 'package:get_it/get_it.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/activate_method_usecase/activate_method_usecase.dart';
import 'package:sasuki/domain/usecase/user_activation_informs_usecase/user_activation_informs_usecase.dart';
import 'package:sasuki/presentation/user_activation/viewmodel/user_activation_viewmodel.dart';

initUserActivationModule() async {
  // activation api module, only users list screen dependencies are here
  // shared preferences instance
  if (!GetIt.I.isRegistered<ActivationInformsUsecase>()) {
    instance.registerFactory<ActivationInformsUsecase>(
      () => ActivationInformsUsecase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<ActivateMethodUseCase>()) {
    instance.registerFactory<ActivateMethodUseCase>(
      () => ActivateMethodUseCase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<UserActivationViewModel>()) {
    // user activation view model instance
    instance.registerLazySingleton<UserActivationViewModel>(
      () => UserActivationViewModel(
        instance<ActivationInformsUsecase>(),
        instance<ActivateMethodUseCase>(),
      ),
    );
  }
}
