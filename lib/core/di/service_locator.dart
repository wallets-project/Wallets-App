import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallets/core/networking/api_constants.dart';
import 'package:wallets/core/networking/api_service.dart';
import 'package:wallets/core/networking/dio_factory.dart';
import 'package:wallets/core/storage/token_storage.dart';



final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  // TokenStorage
  sl.registerLazySingleton<TokenStorage>(() => TokenStorage(sl()));

  // Dio
  sl.registerLazySingleton(() {
    return DioFactory.create(
      baseUrl: ApiConstants.baseApiUrl,
      tokenProvider: () => sl<TokenStorage>().getToken(),
    );
  });

  // ApiService
  sl.registerLazySingleton<ApiService>(() => ApiService(sl()));
}
