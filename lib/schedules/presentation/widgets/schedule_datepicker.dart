import 'package:doc_hunter_app/schedules/domain/entities/date_entity.dart';
import 'package:doc_hunter_app/schedules/domain/usecases/params/schedule_date_params.dart';
import 'package:doc_hunter_app/schedules/presentation/bloc/date_bloc/date_bloc.dart';
import 'package:doc_hunter_app/schedules/presentation/bloc/date_bloc/date_event.dart';
import 'package:doc_hunter_app/schedules/presentation/bloc/date_bloc/date_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ScheduleDatePicker extends StatelessWidget {
  final int filialId;
  final int filialCacheId;
  final int departmentId;
  final int doctorId;

  const ScheduleDatePicker(
      {Key? key,
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

      void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
        String selectedDate = args.value.toString();
        String date = selectedDate.substring(0, 4) +
            selectedDate.substring(5, 7) +
            selectedDate.substring(8, 10);
        context.read<DateBloc>().add(SelectDateEvent(date));
      }

      return SizedBox(
        height: 300,
        child: SfDateRangePicker(
          onSelectionChanged: _onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.single,
          minDate: DateTime.now(),
          maxDate: DateTime.now().add(const Duration(days: 62)),
          monthViewSettings: DateRangePickerMonthViewSettings(
            firstDayOfWeek: 1,
            specialDates: _getFreeTime(dates),
          ),
          monthCellStyle: DateRangePickerMonthCellStyle(
            weekendDatesDecoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(color: Colors.grey.shade700, width: 1),
                shape: BoxShape.circle),
            specialDatesDecoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(color: const Color(0xFF2B732F), width: 1),
                shape: BoxShape.circle),
            specialDatesTextStyle: const TextStyle(color: Colors.white),
          ),
        ),
      );
    });
  }

  List<DateTime> _getFreeTime(List<DateEntity> dates) {
    return dates
        .map((e) => DateTime(
            int.parse(e.date.substring(0, 4)),
            int.parse(e.date.substring(4, 6)),
            int.parse(e.date.substring(6, 8))))
        .toList();
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
