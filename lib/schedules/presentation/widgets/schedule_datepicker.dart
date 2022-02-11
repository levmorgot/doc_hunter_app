import 'package:doc_hunter_app/common/app_colors.dart';
import 'package:doc_hunter_app/common/widgets/doc_progress_indicator.dart';
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
    BlocProvider.of<DateBloc>(
      context,
      listen: false,
    ).add(
      GetDateEvent(
        ScheduleDateParams(
          filialCacheId: filialCacheId,
          filiaId: filialId,
          departmentId: departmentId,
          doctorId: doctorId,
        ),
      ),
    );
    final DateTime minDate = DateTime.now();
    final DateTime maxDate = minDate.add(
      const Duration(days: 62),
    );
    return BlocBuilder<DateBloc, DateState>(builder: (
      context,
      state,
    ) {
      List<DateTime> freeDates = [];
      List<DateTime> norFreeDates = [];
      if (state is DateLoadingState) {
        return _loadingIndicator();
      } else if (state is DateLoadedState) {
        freeDates = _getFreeDates(state.dates);
        norFreeDates = _getNotFreeDates(freeDates);
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
          selectionColor: AppColors.selectionDate,
          onSelectionChanged: _onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.single,
          minDate: minDate,
          maxDate: maxDate,
          monthViewSettings: DateRangePickerMonthViewSettings(
            firstDayOfWeek: 1,
            specialDates: freeDates,
            weekendDays: const [6, 7],
          ),
          monthCellStyle: DateRangePickerMonthCellStyle(
            weekendDatesDecoration: BoxDecoration(
                color: AppColors.weekendDatesBackground,
                border: Border.all(
                  color: AppColors.weekendDatesBorder,
                  width: 1,
                ),
                shape: BoxShape.circle),
            specialDatesDecoration: BoxDecoration(
              color: AppColors.freeDatesBackground,
              border: Border.all(
                color: AppColors.freeDatesBorder,
                width: 1,
              ),
              shape: BoxShape.circle,
            ),
            specialDatesTextStyle: const TextStyle(
              color: AppColors.freeDatesText,
            ),
          ),
        ),
      );
    });
  }

  List<DateTime> _getFreeDates(List<DateEntity> dates) {
    return dates
        .map((e) => DateTime(
            int.parse(e.date.substring(0, 4)),
            int.parse(e.date.substring(4, 6)),
            int.parse(e.date.substring(6, 8))))
        .toList();
  }

  List<DateTime> _getNotFreeDates(List<DateTime> freeDates) {
    List<DateTime> notFreeDate = [];
    final DateTime startDate = DateTime.now();
    DateTime currentDate = startDate;
    while (currentDate.difference(startDate).inDays < 62) {
      final DateTime onlyDate = DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day,
      );
      if (!freeDates.contains(onlyDate)) {
        notFreeDate.add(currentDate);
      }
      currentDate = currentDate.add(
        const Duration(days: 1),
      );
    }
    return notFreeDate;
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: DocProgressIndicator(),
      ),
    );
  }
}
