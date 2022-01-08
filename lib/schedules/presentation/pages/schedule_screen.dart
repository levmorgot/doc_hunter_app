import 'package:doc_hunter_app/schedules/presentation/widgets/schedule_datepicker.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  final int filialId;
  final int filialCacheId;
  final int departmentId;
  final int doctorId;

  const SchedulePage(
      {Key? key,
      required this.filialId,
      required this.filialCacheId,
      required this.departmentId,
      required this.doctorId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Расписание'),
        centerTitle: true,
      ),
      body: ScheduleDatePicker(
        filialId: filialId,
        filialCacheId: filialCacheId,
        departmentId: departmentId,
        doctorId: doctorId,
      ),
    );
  }
}
