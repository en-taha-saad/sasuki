import 'package:get_it/get_it.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/servers_usecase/add_server_usecase.dart';
import 'package:sasuki/presentation/add_server/viewmodel/add_server_viewmodel.dart';

initAddServerModule() {
  // add server module, only login dependencies are here
  if (!GetIt.I.isRegistered<AddServerUseCase>()) {
    // choose server use case instance
    instance.registerFactory<AddServerUseCase>(
      () => AddServerUseCase(instance<Repository>()),
    );
    // choose server view model instance
    instance.registerFactory<AddServerViewModel>(
      () => AddServerViewModel(instance<AddServerUseCase>()),
    );
  }
}
