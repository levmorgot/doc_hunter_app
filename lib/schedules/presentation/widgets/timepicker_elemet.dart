import 'package:flutter/material.dart';

class TimepickerElement extends StatelessWidget {
  final String time;
  final bool isFree;

  const TimepickerElement({Key? key, required this.time, required this.isFree}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(2),
      height: 15,
      decoration: BoxDecoration(
        color: isFree ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        time,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
