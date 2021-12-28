import 'package:doc_hunter_app/core/platform/network_info.dart';
import 'package:doc_hunter_app/filials/data/datasources/filial_remote_data_sources.dart';
import 'package:doc_hunter_app/filials/domain/repositories/filial_repository.dart';
import 'package:doc_hunter_app/filials/domain/usecases/get_all_filials.dart';
import 'package:doc_hunter_app/filials/domain/usecases/search_filial.dart';
import 'package:doc_hunter_app/filials/presentation/bloc/filials_list_cubit/filials_list_cubit.dart';
import 'package:doc_hunter_app/filials/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'filials/data/datasources/filial_local_data_sources.dart';
import 'filials/data/repositories/filial_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BloC / Cubit
  sl.registerFactory(() => FilialsListCubit(getAllFilials: sl(), limit: sl()));
  sl.registerFactory(() => FilialSearchBloc(searchFilial: sl()));

  // UseCases
  sl.registerLazySingleton(() => GetAllFilials(sl()));
  sl.registerLazySingleton(() => SearchFilial(sl()));

  // Repository
  sl.registerLazySingleton<IFilialRepository>(() => FilialRepository(
      localDataSource: sl(), networkInfo: sl(), remoteDataSource: sl()));

  sl.registerLazySingleton<IFilialRemoteDataSource>(
      () => FilialRemoteDataSource(client: http.Client()));

  sl.registerLazySingleton<IFilialLocalDataSource>(
      () => FilialLocalDataSource(sharedPreferences: sl()));

  // Core
  sl.registerLazySingleton<INetworkInfo>(() => NetworkInfo(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
