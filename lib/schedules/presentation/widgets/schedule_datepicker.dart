import 'package:doc_hunter_app/schedules/domain/entities/date_entity.dart';
import 'package:doc_hunter_app/schedules/domain/usecases/params/schedule_date_params.dart';
import 'package:doc_hunter_app/schedules/presentation/bloc/date_bloc/date_bloc.dart';
import 'package:doc_hunter_app/schedules/presentation/bloc/date_bloc/date_event.dart';
import 'package:doc_hunter_app/schedules/presentation/bloc/date_bloc/date_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleDatePicker extends StatelessWidget {
  final int filialId;
  final int filialCacheId;
  final int departmentId;
  final int doctorId;

  const ScheduleDatePicker({Key? key,
    required this.filialId,
    required this.filialCacheId,
    required this.departmentId,
    required this.doctorId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DateBloc>(context, listen: false).add(GetDateEvent(
        ScheduleDateParams(
            filialCacheId: filialCacheId,
            filiaId: filialId,
            departmentId: departmentId,
            doctorId: doctorId)));
    return BlocBuilder<DateBloc, DateState>(builder: (context, state) {
      List<DateEntity> dates = [];
      if (state is DateLoadingState) {
        return _loadingIndicator();
      } else if (state is DateLoadedState) {
        dates = state.dates;
      } else if (state is DateErrorState) {
        return Text(state.message);
      } else {
        return const Center(
          child: Icon(Icons.now_wallpaper),
        );
      }
      void onDateChanged(DateTime _date) {
        print(dates);
        print(_date.toUtc());
        print(dates.where((element) => element.date == "${_date.year}${_date.month}${_date.day}"));
      }
      return CalendarDatePicker(initialDate: DateTime(int.parse(dates[0].date.substring(0,4)), int.parse(dates[0].date.substring(4,6)), int.parse(dates[0].date.substring(6,8))),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 62)),
          onDateChanged: onDateChanged,
          selectableDayPredicate: (DateTime val) =>
          dates.where((element) => element.date == "${val.year}${val.month}${val.day}").isNotEmpty ? false : true,

      );

    });

  }



  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
