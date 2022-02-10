import 'package:doc_hunter_app/common/app_colors.dart';
import 'package:flutter/material.dart';

class ErrorSearchText extends StatelessWidget {
  final String errorMessage;

  const ErrorSearchText({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.searchErrorMessageBackground,
      child: Center(
        child: Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
