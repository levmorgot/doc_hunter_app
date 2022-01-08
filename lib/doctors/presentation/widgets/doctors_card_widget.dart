import 'package:doc_hunter_app/common/app_colors.dart';
import 'package:doc_hunter_app/doctors/domain/entities/doctor_entity.dart';
import 'package:doc_hunter_app/schedules/presentation/pages/schedule_screen.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final DoctorEntity doctor;
  final int filialId;
  final int filialCacheId;
  final int departmentId;

  const DoctorCard(
      {Key? key,
      required this.doctor,
      required this.filialId,
      required this.filialCacheId,
      required this.departmentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => SchedulePage(
                      filialCacheId: filialCacheId,
                      filialId: filialId,
                      departmentId: departmentId,
                      doctorId: doctor.id,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                doctor.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
