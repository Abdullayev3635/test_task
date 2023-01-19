import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:uic_task/features/continent/data/datasource/continent_remote_datasource.dart';
import 'package:uic_task/features/continent/data/repository/continent_repo.dart';
import 'package:uic_task/features/continent/domain/repositories/continent_repo_impl.dart';
import 'package:uic_task/features/countries/data/repository/country_repo.dart';
import 'package:uic_task/features/countries/domain/usescases/usescase.dart';
import 'package:uic_task/features/countries/presentation/bloc/country_bloc.dart';

import '../core/network/graphql_gen.dart';
import '../core/network/network_info.dart';
import '../features/continent/data/datasource/continent_local_datasource.dart';
import '../features/continent/domain/usescases/usescase.dart';
import '../features/continent/presentation/bloc/continent_bloc.dart';
import '../features/countries/data/datasource/country_local_datasource.dart';
import '../features/countries/data/datasource/country_remote_datasource.dart';
import '../features/countries/domain/repositories/country_repo_impl.dart';

final di = GetIt.instance;

Future<void> init() async {
  /// Blocs
  di.registerFactory(
    () => ContinentBloc(usesContinent: di()),
  );

  di.registerFactory(
    () => CountryBloc(usesCountry: di()),
  );

  /// UsesCases

  di.registerLazySingleton(() => UsesContinent(continentRepository: di()));

  di.registerLazySingleton(() => UsesCountry(countryRepositoryImpl: di()));

  /// Data sources

  di.registerLazySingleton(
    () => ContinentRemoteDatasourceImpl(di()),
  );
  di.registerLazySingleton(
    () => CountryRemoteDatasourceImpl(di()),
  );

  di.registerLazySingleton<ContinentLocalDatasource>(
    () => ContinentLocalDataSourceImpl(),
  );
  di.registerLazySingleton<CountryLocalDatasource>(
    () => CountryLocalDataSourceImpl(),
  );

  ///Repositories

  di.registerLazySingleton<ContinentRepositoryImpl>(
    () => ContinentRepository(
      networkInfo: di(),
      remoteDatasource: di(),
      localDatasource: di(),
    ),
  );
  di.registerLazySingleton<CountryRepositoryImpl>(
    () => CountryRepository(
      networkInfo: di(),
      remoteDatasource: di(),
      localDatasource: di(),
    ),
  );

  ///Network

  di.registerLazySingleton<GraphQLClient>(
      () => GraphQLClientGenerator().getClient());

  /// Network Info
  di.registerLazySingleton(() => InternetConnectionChecker());

  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(di()));

  /// Local datasource
  await Hive.initFlutter();
  await Hive.openBox<dynamic>("uic-group_task-continent");
  await Hive.openBox<dynamic>("uic-group_task-country");
}
