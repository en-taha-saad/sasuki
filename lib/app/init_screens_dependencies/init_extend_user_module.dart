import 'package:get_it/get_it.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/extend_user_informs_usecases/allowed_extensions_informs_usecase.dart';
import 'package:sasuki/domain/usecase/extend_user_informs_usecases/extend_user_informs_usecase.dart';
import 'package:sasuki/domain/usecase/extend_user_informs_usecases/extend_user_usecase.dart';
import 'package:sasuki/presentation/extend_user/viewmodel/extend_user_viewmodel.dart';

initExtendUserModule() async {
  // extend user api module, only users list screen dependencies are here
  // shared preferences instance
  if (!GetIt.I.isRegistered<ExtendUserUsecase>()) {
    instance.registerFactory<ExtendUserUsecase>(
      () => ExtendUserUsecase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<ExtendUserInformsUsecase>()) {
    instance.registerFactory<ExtendUserInformsUsecase>(
      () => ExtendUserInformsUsecase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<AllowedExtensionsUsecase>()) {
    instance.registerFactory<AllowedExtensionsUsecase>(
      () => AllowedExtensionsUsecase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<ExtendUserViewModel>()) {
    // user activation view model instance
    instance.registerLazySingleton<ExtendUserViewModel>(
      () => ExtendUserViewModel(
        instance<ExtendUserUsecase>(),
        instance<ExtendUserInformsUsecase>(),
        instance<AllowedExtensionsUsecase>(),
      ),
    );
  }
}
