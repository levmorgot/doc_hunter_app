import 'package:doc_hunter_app/common/app_colors.dart';
import 'package:doc_hunter_app/departments/domain/entities/department_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DepartmentCard extends StatelessWidget {
  final DepartmentEntity department;

  const DepartmentCard({Key? key, required this.department}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
