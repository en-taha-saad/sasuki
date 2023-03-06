import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sasuki/app/app_inits_funs/app_prefs.dart';
import 'package:sasuki/app/app_inits_funs/constants.dart';
import 'package:sasuki/app/shared_funs/get_selectedserver_fromlocal.dart';
import 'package:sasuki/data/data_sources/local/local_data_source.dart';
import 'package:sasuki/data/data_sources/local/local_data_source_impl.dart';
import 'package:sasuki/data/data_sources/remote/remote_data_source.dart';
import 'package:sasuki/data/data_sources/remote/remote_data_source_impl.dart';
import 'package:sasuki/data/network/app_api.dart';
import 'package:sasuki/data/network/dio_instance/dio_factory.dart';
import 'package:sasuki/data/network/internet_checker/network_info.dart';
import 'package:sasuki/data/network/internet_checker/network_info_impl.dart';
import 'package:sasuki/data/repository/repository_impl.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, all generic dependencies are here

  // shared preferences instance
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app preferences instance
  instance.registerLazySingleton<AppPreferences>(
    () => AppPreferences(instance<SharedPreferences>()),
  );

  // network info instance
  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(InternetConnectionChecker()),
  );

  // dio factory instance
  instance.registerLazySingleton<DioFactory>(
    () => DioFactory(instance<AppPreferences>()),
  );

  // app service client instance
  Dio dio = await instance<DioFactory>().getDio();
  final server = await getSelectedServerFromLocal();

  // final Server server = await getSelectedServerFromLocal();
  instance.registerLazySingleton<AppServiceClient>(
    () => AppServiceClient(
      dio,
      baseUrl: "https://${server.hostName}/${Constants.suffixUrl}",
    ),
  );

  // remote data source instance
  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(instance<AppServiceClient>()),
  );

  // remote data source instance
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // repository instance
  instance.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      instance<LocalDataSource>(),
      instance<RemoteDataSource>(),
      instance<NetworkInfo>(),
    ),
  );
}
