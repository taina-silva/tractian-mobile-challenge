import 'package:get_it/get_it.dart';
import 'package:tractian_mobile_challenge/app/core/infra/datasources/companies_datasource.dart';
import 'package:tractian_mobile_challenge/app/core/infra/repositories/companies_repository.dart';
import 'package:tractian_mobile_challenge/app/core/services/rest_client.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/stores/assets_store.dart';
import 'package:tractian_mobile_challenge/app/features/home/presentation/stores/home_store.dart';
import 'package:tractian_mobile_challenge/app/features/splash/presentation/stores/splash_store.dart';

abstract class ProvidersSetup {
  void setup();
}

class AppProviders extends ProvidersSetup {
  final GetIt getIt = GetIt.instance;

  @override
  void setup() {
    // app
    getIt.registerSingleton<RestClient>(RestClient());
    getIt.registerFactory<ICompaniesDatasource>(() => CompaniesDatasource(getIt.get<RestClient>()));
    getIt.registerLazySingleton<ICompaniesRepository>(
        () => CompaniesRepository(getIt.get<ICompaniesDatasource>()));

    // splash
    getIt.registerLazySingleton<SplashStore>(() => SplashStore());

    // home
    getIt.registerLazySingleton<HomeStore>(() => HomeStore(getIt.get<ICompaniesRepository>()));

    // assets
    getIt.registerLazySingleton<AssetsStore>(() => AssetsStore());
  }
}
