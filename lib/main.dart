import 'package:doc_hunter_app/common/app_colors.dart';
import 'package:doc_hunter_app/departments/presentation/bloc/departments_list_cubit/departments_list_cubit.dart';
import 'package:doc_hunter_app/departments/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:doc_hunter_app/filials/presentation/bloc/filials_list_cubit/filials_list_cubit.dart';
import 'package:doc_hunter_app/filials/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:doc_hunter_app/locator_service.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        ],
        child: MaterialApp(
          theme: ThemeData.dark().copyWith(
            backgroundColor: AppColors.mainBackground,
            scaffoldBackgroundColor: AppColors.mainBackground,
          ),
          home: const HomePage(),
        ));
  }
}
