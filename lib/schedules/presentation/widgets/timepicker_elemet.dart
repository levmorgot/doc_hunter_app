import 'package:doc_hunter_app/common/app_colors.dart';
import 'package:flutter/material.dart';

class TimepickerElement extends StatelessWidget {
  final String time;
  final bool isFree;

  const TimepickerElement({
    Key? key,
    required this.time,
    required this.isFree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(2),
      height: 15,
      decoration: BoxDecoration(
        color: isFree ? AppColors.freeTime : AppColors.notFreeTime,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        time,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }
}
