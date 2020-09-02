import 'package:get_it/get_it.dart';
import '../services/signout_service.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../services/dialog_service.dart';
import '../services/navigation_service.dart';
import '../services/loading_service.dart';
import '../services/pushnotification_service.dart';
import '../services/shareddata_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => LoadingService());
  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => SharedDataService());
  locator.registerLazySingleton(() => SignOutService());
}
