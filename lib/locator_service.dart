import 'package:doc_hunter_app/core/platform/network_info.dart';
import 'package:doc_hunter_app/departments/data/datasources/department_local_data_sources.dart';
import 'package:doc_hunter_app/departments/data/datasources/department_remote_data_sources.dart';
import 'package:doc_hunter_app/departments/data/repositories/department_repository.dart';
import 'package:doc_hunter_app/departments/domain/repositories/department_repository.dart';
import 'package:doc_hunter_app/departments/domain/usecases/get_all_departments.dart';
import 'package:doc_hunter_app/departments/domain/usecases/search_department.dart';
import 'package:doc_hunter_app/departments/presentation/bloc/departments_list_cubit/departments_list_cubit.dart';
import 'package:doc_hunter_app/departments/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:doc_hunter_app/doctors/data/datasources/doctor_local_data_sources.dart';
import 'package:doc_hunter_app/doctors/data/datasources/doctor_remote_data_sources.dart';
import 'package:doc_hunter_app/doctors/data/repositories/doctor_repository.dart';
import 'package:doc_hunter_app/doctors/domain/repositories/doctor_repository.dart';
import 'package:doc_hunter_app/doctors/domain/usecases/get_all_doctors.dart';
import 'package:doc_hunter_app/doctors/domain/usecases/search_doctor.dart';
import 'package:doc_hunter_app/doctors/presentation/bloc/doctors_list_cubit/doctors_list_cubit.dart';
import 'package:doc_hunter_app/doctors/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:doc_hunter_app/filials/data/datasources/filial_local_data_sources.dart';
import 'package:doc_hunter_app/filials/data/datasources/filial_remote_data_sources.dart';
import 'package:doc_hunter_app/filials/data/repositories/filial_repository.dart';
import 'package:doc_hunter_app/filials/domain/repositories/filial_repository.dart';
import 'package:doc_hunter_app/filials/domain/usecases/get_all_filials.dart';
import 'package:doc_hunter_app/filials/domain/usecases/search_filial.dart';
import 'package:doc_hunter_app/filials/presentation/bloc/filials_list_cubit/filials_list_cubit.dart';
import 'package:doc_hunter_app/filials/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:doc_hunter_app/schedules/data/datasources/schedule_remote_data_sources.dart';
import 'package:doc_hunter_app/schedules/data/repositories/schedule_repository.dart';
import 'package:doc_hunter_app/schedules/domain/repositories/schedule_repository.dart';
import 'package:doc_hunter_app/schedules/domain/usecases/get_all_date.dart';
import 'package:doc_hunter_app/schedules/domain/usecases/get_all_time_for_date.dart';
import 'package:doc_hunter_app/schedules/presentation/bloc/date_bloc/date_bloc.dart';
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

  sl.registerFactory(
        () => DoctorsListCubit(getAllDoctors: sl(), limit: 15),
  );
  sl.registerFactory(
        () => DoctorSearchBloc(searchDoctor: sl()),
  );

  sl.registerFactory(
        () => DateBloc(getAllDate: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetAllFilials(sl()));
  sl.registerLazySingleton(() => SearchFilial(sl()));

  sl.registerLazySingleton(() => GetAllDepartments(sl()));
  sl.registerLazySingleton(() => SearchDepartment(sl()));

  sl.registerLazySingleton(() => GetAllDoctors(sl()));
  sl.registerLazySingleton(() => SearchDoctor(sl()));

  sl.registerLazySingleton(() => GetAllDate(sl()));
  sl.registerLazySingleton(() => GetAllTimeForDate(sl()));

  // Repository filial
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


  // Repository departments
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

  // Repository doctors
  sl.registerLazySingleton<IDoctorRepository>(
        () => DoctorRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<IDoctorRemoteDataSource>(
        () => DoctorRemoteDataSource(
      client: http.Client(),
    ),
  );

  sl.registerLazySingleton<IDoctorLocalDataSource>(
        () => DoctorLocalDataSource(sharedPreferences: sl()),
  );


  // Repository schedule
  sl.registerLazySingleton<IScheduleRepository>(
        () => ScheduleRepository(
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<IScheduleRemoteDataSource>(
        () => ScheduleRemoteDataSource(
      client: http.Client(),
    ),
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
