import 'package:get_it/get_it.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/managers_list_details_usecase/managers_list_details_usecase.dart';
import 'package:sasuki/presentation/managers_list/viewmodel/managers_list_viewmodel.dart';

initManagersListModule() async {
  // users list module, only users list screen dependencies are here
  // shared preferences instance
  if (!GetIt.I.isRegistered<ManagersListDetailsUsecase>()) {
    instance.registerFactory<ManagersListDetailsUsecase>(
      () => ManagersListDetailsUsecase(instance<Repository>()),
    );
  }

  // parent list module, only users list screen dependencies are here
  // shared preferences instance
  // TODO: replace this with the new usecase
  // if (!GetIt.I.isRegistered<ParentListUseCase>()) {
  //   instance.registerFactory<ParentListUseCase>(
  //     () => ParentListUseCase(instance<Repository>()),
  //   );
  // }

  if (!GetIt.I.isRegistered<ManagersListViewModel>()) {
    // users list view model instance
    instance.registerLazySingleton<ManagersListViewModel>(
        () => ManagersListViewModel(
              instance<ManagersListDetailsUsecase>(),
            ));
  }
}
