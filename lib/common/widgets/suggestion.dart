import 'package:flutter/material.dart';

class Suggestion extends StatelessWidget {
  final String suggestion;

  final VoidCallback onTap;

  const Suggestion({
    Key? key,
    required this.suggestion,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        suggestion,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
