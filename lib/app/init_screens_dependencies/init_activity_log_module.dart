import 'package:get_it/get_it.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/activity_log_usecases/activity_log_events_usecase.dart';
import 'package:sasuki/domain/usecase/activity_log_usecases/activity_log_list_usecase.dart';

initActivityLogModule() async {
  if (!GetIt.I.isRegistered<ActivityLogListUseCase>()) {
    instance.registerFactory<ActivityLogListUseCase>(
      () => ActivityLogListUseCase(instance<Repository>()),
    );
  }

  if (!GetIt.I.isRegistered<ActivityLogEventsUseCase>()) {
    instance.registerFactory<ActivityLogEventsUseCase>(
      () => ActivityLogEventsUseCase(instance<Repository>()),
    );
  }

  // if (!GetIt.I.isRegistered<ActivityLogViewModel>()) {
  //   // users list view model instance
  //   instance
  //       .registerLazySingleton<ActivityLogViewModel>(() => ActivityLogViewModel(
  //             instance<ActivityLogListUseCase>(),
  //             instance<ActivityLogEventsUseCase>(),
  //           ));
  // }
}
