import 'package:doc_hunter_app/core/platform/network_info.dart';
import 'package:doc_hunter_app/departments/data/datasources/department_local_data_sources.dart';
import 'package:doc_hunter_app/departments/data/datasources/department_remote_data_sources.dart';
import 'package:doc_hunter_app/departments/data/repositories/department_repository.dart';
import 'package:doc_hunter_app/departments/domain/repositories/department_repository.dart';
import 'package:doc_hunter_app/departments/domain/usecases/get_all_departments.dart';
import 'package:doc_hunter_app/departments/domain/usecases/search_department.dart';
import 'package:doc_hunter_app/departments/presentation/bloc/departments_list_cubit/departments_list_cubit.dart';
import 'package:doc_hunter_app/departments/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:doc_hunter_app/filials/data/datasources/filial_local_data_sources.dart';
import 'package:doc_hunter_app/filials/data/datasources/filial_remote_data_sources.dart';
import 'package:doc_hunter_app/filials/data/repositories/filial_repository.dart';
import 'package:doc_hunter_app/filials/domain/repositories/filial_repository.dart';
import 'package:doc_hunter_app/filials/domain/usecases/get_all_filials.dart';
import 'package:doc_hunter_app/filials/domain/usecases/search_filial.dart';
import 'package:doc_hunter_app/filials/presentation/bloc/filials_list_cubit/filials_list_cubit.dart';
import 'package:doc_hunter_app/filials/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // BloC / Cubit
  sl.registerFactory(
    () => FilialsListCubit(getAllFilials: sl(), limit: 15),
  );
  sl.registerFactory(
    () => FilialSearchBloc(searchFilial: sl()),
  );

  sl.registerFactory(
        () => DepartmentsListCubit(getAllDepartments: sl(), limit: 15),
  );
  sl.registerFactory(
        () => DepartmentSearchBloc(searchDepartment: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetAllFilials(sl()));
  sl.registerLazySingleton(() => SearchFilial(sl()));

  sl.registerLazySingleton(() => GetAllDepartments(sl()));
  sl.registerLazySingleton(() => SearchDepartment(sl()));

  // Repository
  sl.registerLazySingleton<IFilialRepository>(
    () => FilialRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<IFilialRemoteDataSource>(
    () => FilialRemoteDataSource(
      client: http.Client(),
    ),
  );

  sl.registerLazySingleton<IFilialLocalDataSource>(
    () => FilialLocalDataSource(sharedPreferences: sl()),
  );


  //departments
  sl.registerLazySingleton<IDepartmentRepository>(
        () => DepartmentRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<IDepartmentRemoteDataSource>(
        () => DepartmentRemoteDataSource(
      client: http.Client(),
    ),
  );

  sl.registerLazySingleton<IDepartmentLocalDataSource>(
        () => DepartmentLocalDataSource(sharedPreferences: sl()),
  );

  // Core
  sl.registerLazySingleton<INetworkInfo>(
    () => NetworkInfo(sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
