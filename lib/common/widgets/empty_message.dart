import 'package:flutter/material.dart';

class EmptyMessage extends StatelessWidget {
  final String message;

  const EmptyMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
