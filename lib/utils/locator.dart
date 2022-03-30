import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volt_driver/data/local/local.dart';
import 'package:volt_driver/data/remote/auth_apis/auth_repo.dart';
import 'package:volt_driver/data/remote/auth_apis/auth_service.dart';
import 'package:volt_driver/data/remote/connectivity_service.dart';
import 'package:volt_driver/data/remote/direction_apis/direction_repo.dart';
import 'package:volt_driver/data/remote/direction_apis/direction_service.dart';
import 'package:volt_driver/data/remote/order_apis/order_repo.dart';
import 'package:volt_driver/data/remote/order_apis/order_service.dart';
import 'package:volt_driver/handlers/handlers.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator({String baseApi = ''}) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton(sharedPreferences);
  //Local storage
  locator.registerLazySingleton<SecureStorage>(
    () => SecureStorageImpl(),
  );

  locator.registerLazySingleton<LocalCache>(
    () => LocalCacheImpl(
      sharedPreferences: locator(),
      storage: locator(),
    ),
  );

//handlers
  locator
      .registerLazySingleton<NavigationHandler>(() => NavigationHandlerImpl());
  locator.registerLazySingleton<DialogHandler>(() => DialogHandlerImpl());
  locator.registerLazySingleton<UrlLaunchHandler>(() => UrlLaunchHandlerImpl());

  //services

  locator.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(),
  );
  locator.registerLazySingleton<AuthService>(
    () => AuthServiceImpl(
      authRepo: locator(),
      cache: locator(),
    ),
  );

  locator.registerLazySingleton<OrderService>(
    () => OrderServiceImpl(orderRepo: locator()),
  );

  locator.registerLazySingleton<DirectionService>(
    () => DirectionServiceImpl(locator()),
  );
  //repos
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(baseApi),
  );

  locator.registerLazySingleton<OrderRepo>(
    () => OrderRepoImpl(baseApi),
  );

  locator.registerLazySingleton<DirectionRepository>(
    () => DirectionRepoImpl("maps.googleapis.com/maps/api/directions/json?"),
  );
}
