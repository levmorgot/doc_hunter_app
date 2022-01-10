import 'package:doc_hunter_app/schedules/domain/entities/time_entity.dart';
import 'package:doc_hunter_app/schedules/domain/usecases/params/schedule_time_params.dart';
import 'package:doc_hunter_app/schedules/presentation/bloc/date_bloc/date_bloc.dart';
import 'package:doc_hunter_app/schedules/presentation/bloc/date_bloc/date_state.dart';
import 'package:doc_hunter_app/schedules/presentation/bloc/time_bloc/time_bloc.dart';
import 'package:doc_hunter_app/schedules/presentation/bloc/time_bloc/time_event.dart';
import 'package:doc_hunter_app/schedules/presentation/bloc/time_bloc/time_state.dart';
import 'package:doc_hunter_app/schedules/presentation/widgets/timepicker_elemet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleTimePicker extends StatelessWidget {
  final int filialId;
  final int filialCacheId;
  final int departmentId;
  final int doctorId;

  const ScheduleTimePicker(
      {Key? key,
      required this.filialId,
      required this.filialCacheId,
      required this.departmentId,
      required this.doctorId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DateBloc, DateState, String?>(
      selector: (state) {
        return state is DateLoadedState ? state.selectedDate : null;
      },
      builder: (context, selectedDate) {
        if (selectedDate != null) {
          BlocProvider.of<TimeBloc>(context, listen: false).add(GetTimeEvent(
              ScheduleTimeParams(
                  filialCacheId: filialCacheId,
                  filialId: filialId,
                  departmentId: departmentId,
                  doctorId: doctorId,
                  date: selectedDate)));
          return BlocBuilder<TimeBloc, TimeState>(builder: (context, state) {
            List<TimeEntity> times = [];
            if (state is TimeLoadingState) {
              return _loadingIndicator();
            } else if (state is TimeLoadedState) {
              times = state.times;
            } else if (state is TimeErrorState) {
              return Text(state.message);
            }
            return SizedBox(
              height: 300,
              child: times.isNotEmpty
                  ? _timesList(times)
                  : const Text('Нет свободных записей'),
            );
          });
        } else {
          return const Center(
            child: Text('Выберете дату'),
          );
        }
      },
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _timesList(List<TimeEntity> times) {
    List<Widget> timesList = [];
    for (var elem in times) {
      timesList.add(TimepickerElement(time: elem.time, isFree: elem.isFree));
    }

    return Container(
      margin: const EdgeInsets.all(10),
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 3,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        children: timesList,
      ),
    );
  }
}
