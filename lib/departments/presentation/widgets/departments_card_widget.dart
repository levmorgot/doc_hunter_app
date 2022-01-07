import 'package:doc_hunter_app/common/app_colors.dart';
import 'package:doc_hunter_app/departments/domain/entities/department_entity.dart';
import 'package:doc_hunter_app/doctors/presentation/pages/doctors_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DepartmentCard extends StatelessWidget {
  final DepartmentEntity department;
  final int filialId;
  final int filialCacheId;

  const DepartmentCard({Key? key, required this.department, required this.filialId, required this.filialCacheId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DoctorsPage(filialCacheId: filialCacheId, filialId: filialId,)));
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
                department.name,
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
