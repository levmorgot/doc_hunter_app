import 'package:doc_hunter_app/common/app_colors.dart';
import 'package:doc_hunter_app/departments/presentation/bloc/departments_list_cubit/departments_list_cubit.dart';
import 'package:doc_hunter_app/departments/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:doc_hunter_app/doctors/presentation/bloc/doctors_list_cubit/doctors_list_cubit.dart';
import 'package:doc_hunter_app/doctors/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:doc_hunter_app/filials/presentation/bloc/filials_list_cubit/filials_list_cubit.dart';
import 'package:doc_hunter_app/filials/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:doc_hunter_app/locator_service.dart' as di;
import 'package:doc_hunter_app/schedules/presentation/bloc/date_bloc/date_bloc.dart';
import 'package:doc_hunter_app/schedules/presentation/bloc/time_bloc/time_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'filials/presentation/pages/filials_screen.dart';
import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<FilialsListCubit>(
              create: (context) => sl<FilialsListCubit>()..loadFilials()),
          BlocProvider<FilialSearchBloc>(
              create: (context) => sl<FilialSearchBloc>()),
          BlocProvider<DepartmentsListCubit>(
              create: (context) => sl<DepartmentsListCubit>()),
          BlocProvider<DepartmentSearchBloc>(
              create: (context) => sl<DepartmentSearchBloc>()),
          BlocProvider<DoctorsListCubit>(
              create: (context) => sl<DoctorsListCubit>()),
          BlocProvider<DoctorSearchBloc>(
              create: (context) => sl<DoctorSearchBloc>()),
          BlocProvider<DateBloc>(
              create: (context) => sl<DateBloc>()),
          BlocProvider<TimeBloc>(
              create: (context) => sl<TimeBloc>()),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            // ... app-specific localization delegate[s] here
            SfGlobalLocalizations.delegate
          ],
          //ignore: always_specify_types
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ru', 'RU'),
            // ... other locales the app supports
          ],
          theme: ThemeData.dark().copyWith(
            backgroundColor: AppColors.mainBackground,
            scaffoldBackgroundColor: AppColors.mainBackground,
          ),
          home: const HomePage(),
        ));
  }
}
