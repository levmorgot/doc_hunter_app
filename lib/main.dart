import 'package:doc_hunter_app/filials/presentation/bloc/filials_list_cubit/filials_list_cubit.dart';
import 'package:doc_hunter_app/filials/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:doc_hunter_app/locator_service.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'filials/presentation/pages/filials_list.dart';
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
              create: (context) => sl<FilialsListCubit>()),
          BlocProvider<FilialSearchBloc>(
              create: (context) => sl<FilialSearchBloc>()),
        ],
        child: MaterialApp(
          theme: ThemeData.dark().copyWith(
            backgroundColor: Colors.black,
            scaffoldBackgroundColor: Colors.grey,
          ),
          home: const HomePage(),
        ));
  }
}
