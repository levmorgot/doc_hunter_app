import 'package:doc_hunter_app/common/app_colors.dart';
import 'package:doc_hunter_app/filials/domain/entities/filial_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilialCard extends StatelessWidget {
  final FilialEntity filial;

  const FilialCard({Key? key, required this.filial}) : super(key: key);

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
              filial.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              filial.address,
              style: const TextStyle(
                color: AppColors.greyColor,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              filial.phone,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
