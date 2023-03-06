import 'package:get_it/get_it.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/servers_usecase/remove_server_usecase.dart';
import 'package:sasuki/domain/usecase/servers_usecase/selected_server_usecase.dart';
import 'package:sasuki/domain/usecase/servers_usecase/servers_usecase.dart';

initChooseServerModule() {
  // choose server module, only login dependencies are here

  if (!GetIt.I.isRegistered<ChooseServerUseCase>()) {
    // choose server use case instance
    instance.registerFactory<ChooseServerUseCase>(
      () => ChooseServerUseCase(instance<Repository>()),
    );
  }
  if (!GetIt.I.isRegistered<SelectedServerUsecase>()) {
    instance.registerFactory<SelectedServerUsecase>(
      () => SelectedServerUsecase(instance<Repository>()),
    );
  }
  if (!GetIt.I.isRegistered<RemoveServerUsecase>()) {
    instance.registerFactory<RemoveServerUsecase>(
      () => RemoveServerUsecase(instance<Repository>()),
    );
    // choose server view model instance
  }
  // TODO check the model
  if (!GetIt.I.isRegistered<ChooseServerViewModel>()) {
    instance.registerFactory<ChooseServerViewModel>(
      () => ChooseServerViewModel(
        instance<ChooseServerUseCase>(),
        instance<SelectedServerUsecase>(),
        instance<RemoveServerUsecase>(),
      ),
    );
  }
}
